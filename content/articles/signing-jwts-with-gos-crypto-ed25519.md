---
date: 2019-12-07T00:00:00Z
title: Signing JWTs with Go's crypto/ed25519
---

The [crypto/ed25519](https://golang.org/pkg/crypto/ed25519) package was added to the standard library in [Go 1.13](https://golang.org/doc/go1.13#crypto/ed25519). This package implements the [Ed25519](https://ed25519.cr.yp.to/) Edwards-curve Digital Signature Algorithm. It offers significant speed and security improvements over RSA and it makes for a perfect signing method for JWTs. Unfortunately, the [most popular JWT library for Go](https://godoc.org/github.com/dgrijalva/jwt-go) does not natively support it yet. It only supports ECDSA, HMAC, RSA, and RSAPSS, however, it is trivial to extend the package and satisfy the interface [(github.com/dgrijalva/jwt-go).SigningMethod](https://godoc.org/github.com/dgrijalva/jwt-go#SigningMethod) for Ed25519.

## Implementing (github.com/dgrijalva/jwt-go).SigningMethod

```go
type SigningMethodEdDSA struct{}

func (m *SigningMethodEdDSA) Alg() string {
	return "EdDSA"
}

func (m *SigningMethodEdDSA) Verify(signingString string, signature string, key interface{}) error {
	var err error

	var sig []byte
	if sig, err = jwt.DecodeSegment(signature); err != nil {
		return err
	}

	var ed25519Key ed25519.PublicKey
	var ok bool
	if ed25519Key, ok = key.(ed25519.PublicKey); !ok {
		return jwt.ErrInvalidKeyType
	}

	if len(ed25519Key) != ed25519.PublicKeySize {
		return jwt.ErrInvalidKey
	}

	if ok := ed25519.Verify(ed25519Key, []byte(signingString), sig); !ok {
		return ErrEdDSAVerification
	}

	return nil
}

func (m *SigningMethodEdDSA) Sign(signingString string, key interface{}) (str string, err error) {
	var ed25519Key ed25519.PrivateKey
	var ok bool
	if ed25519Key, ok = key.(ed25519.PrivateKey); !ok {
		return "", jwt.ErrInvalidKeyType
	}

	if len(ed25519Key) != ed25519.PrivateKeySize {
		return "", jwt.ErrInvalidKey
	}

	// Sign the string and return the encoded result
	sig := ed25519.Sign(ed25519Key, []byte(signingString))
	return jwt.EncodeSegment(sig), nil
}
```

In order to work with the JWT methods above we need to have a [(crypto/ed25119).PrivateKey](https://golang.org/pkg/crypto/ed25519/#PrivateKey) and [(crypto/ed25119).PublicKey](https://golang.org/pkg/crypto/ed25519/#PublicKey) loaded into our application to sign and verify tokens. For this case we will assume these keys are in PEM format and we can load them in from a file or environment varible.

## Private and Public Keys in PEM Format

```go
privateKeyPEM := `-----BEGIN PRIVATE KEY-----
MC4CAQAwBQYDK2VwBCIEIEFMEZrmlYxczXKFxIlNvNGR5JQvDhTkLovJYxwQd3ua
-----END PRIVATE KEY-----`

publicKeyPEM := `-----BEGIN PUBLIC KEY-----
MCowBQYDK2VwAyEAWH7z6hpYqvPns2i4n9yymwvB3APhi4LyQ7iHOT6crtE=
-----END PUBLIC KEY-----`
```

We have to parse these from their string format into actual (crypto/ed25119).PrivateKey and (crypto/ed25119).PublicKey types. We only have to do this once when our application starts up and we can pass these keys around to the functions that need them to do signing and verifying.

## Decoding the Private Key

```go
type ed25519PrivKey struct {
	Version          int
	ObjectIdentifier struct {
		ObjectIdentifier asn1.ObjectIdentifier
	}
	PrivateKey []byte
}

var block *pem.Block
block, _ = pem.Decode(privateKeyPEM)

var asn1PrivKey ed25519PrivKey
asn1.Unmarshal(block.Bytes, &asn1PrivKey)

privateKey := ed25519.NewKeyFromSeed(asn1PrivKey.PrivateKey[2:])
```

## Decoding the Public Key

```go
type ed25519PubKey struct {
	OBjectIdentifier struct {
		ObjectIdentifier asn1.ObjectIdentifier
	}
	PublicKey asn1.BitString
}

var block *pem.Block
block, _ = pem.Decode(publicKeyPEM)

var asn1PubKey ed25519PubKey
asn1.Unmarshal(key, &asn1PubKey)

publicKey := ed25519.PublicKey(asn1PubKey.PublicKey.Bytes)
```

Now that we have implemented the (github.com/dgrijalva/jwt-go).SigningMethod and have a (crypto/ed25519).PrivateKey and (crypto/ed25519).PublicKey we can put this all together to sign and verify JWTs.

```go
var edDSASigningMethod SigningMethodEdDSA

jwt.RegisterSigningMethod(edDSASigningMethod.Alg(), func() jwt.SigningMethod { return &edDSASigningMethod })

token := jwt.NewWithClaims(&edDSASigningMethod, jwt.StandardClaims{
    IssuedAt: time.Now().Unix(),
    Issuer:   "urn:ed25519-jwt",
    Subject:  "someone@example.com",
})

jwtstring := token.SignedString(privateKey)
fmt.Println(jwtstring)
// Outputs: eyJhbGciOiJFRDI1NTE5IiwidHlwI...

token, _ := jwt.Parse(jwtstring, func(token *jwt.Token) (interface{}, error) {
    return publicKey, nil
})
fmt.Println(token.Issuer, token.Subject)
// Outputs: urn:ed25519-jwt someone@example.com
```

The `jwtstring` can be used by clients to verify their identity as any other JWT, but now we are using Ed25519 for signing and verifying tokens like you can with RSA. The [https://jwt.io](https://jwt.io) website is a great tool for working with JWTs and you can see other libraries that support different signing methods. Since Ed25519 is fairly new you will notice that a lot are missing the "EdDSA" algorithm, but now you can at least implement this yourself with not a lot of code or importing a 3rd party dependancy.