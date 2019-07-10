---
date: 2019-01-29T00:00:00Z
title: Encoding Images with Go for the Monochromatic SSD1306 OLED
draft: true
---

To kick things off we need to do a refresher of how data is represented in bytes and bits as hexadecimal and binary numbers. Then we can apply those to representing a monochromatic image which is a single-dimentional array of bytes that the SSD1306 will use to turn on or off the pixels on the display.

## What is a bit and byte?

- bit: a number containing either a 1 or 0
- byte: a number made of of 8 bits (ex. 11001100, 00110101)


```
   0 1 2 3
  +-+-+-+-+
0 | | | | |
  +-+-+-+-+
1 | | | | |
  +-+-+-+-+
2 | | | | |
  +-+-+-+-+
3 | | | | |
  +-+-+-+-+
4 | | | | |
  +-+-+-+-+
5 | | | | |
  +-+-+-+-+
6 | | | | |
  +-+-+-+-+
7 | | | | |
  +-+-+-+-+
```