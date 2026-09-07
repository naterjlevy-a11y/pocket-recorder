# Parts list and physical layout — 6 × 6 × 35 mm

Every part with a real order number, placed at real coordinates, summed and checked. **It fits, with 0.67 mm of headroom.**

---

## 1. The bar

| | |
| --- | --- |
| Outside | 6.00 × 6.00 × 35.00 mm |
| Wall | 0.30 mm (drawn 316L square tube — catalogue stock) |
| Cavity | 5.40 × 5.40 mm |
| Battery | ~28 mAh custom stepped pouch |
| Talk time | **3.7 hours** per charge (realistic 6 mA) |

### Zones down the length

| Zone | From | To | Length |
| --- | --- | --- | --- |
| Top cap + chain bail | 0.00 | 2.50 | 2.50 |
| Battery only — thick step, 4.6 mm | 2.50 | 17.00 | 14.50 |
| Board over battery — thin step, 2.6 mm | 17.00 | 30.00 | 13.00 |
| Black dielectric tip (antenna + light) | 30.00 | 35.00 | 5.00 |

**The board goes at the bottom.** That's what puts the button in the lower third where you wanted it, and puts the LED next to the tip it lights.

### What you see on the outside

| Feature | Position | Face |
| --- | --- | --- |
| **Button pusher** Ø2.6 | **22.2 mm from top — 63% down** | side |
| **Mic port** Ø1.2 + Ø2.6 mesh | 19.2 mm from top | front |
| **Charge pads** 2 × Ø1.6 | bottom of the tip | bottom |
| **Black tip** | last 5 mm | wraps around |

---

## 2. Parts to order

Confidence is marked, because you're going to spend money on this.

| Part | Order number | Size mm | Job | ✓ |
| --- | --- | --- | --- | --- |
| SoC + Bluetooth | **NRF54L15-CAAA-R** (Nordic, CSP47) | 2.45 × 2.25 × 0.50 | brain and radio | verified |
| Microphone | **T5837** (TDK InvenSense) | 3.50 × 2.65 × 0.98 | picks up your voice | verified |
| Flash 16 MB | **W25Q128JW** WLCSP (Winbond) | 2.50 × 2.50 × 0.33 | holds recordings | verified |
| Charger | **BQ25100YFPR** (TI, WCSP) | 1.60 × 0.90 × 0.50 | charges the cell safely | verified |
| Crystal 32 MHz | **NX1612SA-32MHZ** (NDK) — JLCPCB C1986486 | 1.60 × 1.20 × 0.35 | clock for the radio | verified |
| Antenna | **2450AT18A100E** (Johanson) | 3.20 × 1.60 × 1.30 | in the tip | verified |
| Mic vent | **GORE GAW334** | Ø1.6 | waterproof, sound passes | verified |
| Inductor | 0402 DC-DC | 1.00 × 0.50 × 0.55 | power supply | standard |
| Passives ×9 | 0201 | 0.60 × 0.30 | supply + RF tuning | standard |
| LED | 0402 side-fire | 1.00 × 0.50 × 0.45 | lights the tip | pick colour |
| **Tactile switch** | 2.5 × 1.6 class — **confirm before layout** | 2.50 × 1.60 × 0.80 | the button | **needs choosing** |
| **Stepped cell** | Grepow custom, 4.8 wide | stepped 2.6 / 4.6 | ~28 mAh | **needs a quote** |

**Two saved parts worth knowing about:** the nRF54L15 has **crystal load capacitors built in** (settable 4–17 pF in firmware), so the usual two load caps are gone. And there's no separate audio chip, because the T5837 outputs digital data straight to the SoC.

**The two open items are the switch and the cell.** Everything else can be ordered from Digi-Key today. The stepped cell is the long-lead item — quote it first.

---

## 3. Board layout

**3.6 mm wide × 13.0 mm long**, 4-layer rigid-flex, 0.6 mm core. Populated both sides — that's what makes 35 mm possible at all; single-sided needs 25.5 mm and the bar grows to 48 mm.

X is measured from the left edge of the board. Y is measured down the board, and then down the whole bar.

### Bottom side — faces the battery, thin parts only

| Part | X from left | Y on board | Y in bar | Height |
| --- | --- | --- | --- | --- |
| nRF54L15 SoC | 0.57 | 0.40 | 17.40 | 0.50 |
| W25Q128JW flash | 0.55 | 3.10 | 20.10 | 0.33 |
| BQ25100 charger | 1.00 | 6.05 | 23.05 | 0.50 |
| NX1612SA crystal | 1.00 | 7.40 | 24.40 | 0.35 |
| RF match, 3 × 0201 | 0.90 | 9.05 | 26.05 | 0.30 |
| Decoupling, 6 × 0201 | 0.30 | 9.80 | 26.80 | 0.30 |
| Inductor 0402 | 1.30 | 10.85 | 27.85 | 0.55 |
| Programming pads | 1.20 | 11.80 | 28.80 | 0.05 |

### Top side — faces the case wall, tall parts

| Part | X from left | Y on board | Y in bar | Height |
| --- | --- | --- | --- | --- |
| T5837 microphone | 0.48 | 0.40 | **17.40** | 0.98 |
| Tactile switch | 0.55 | 4.35 | **21.35** | 0.80 |
| LED (lights the tip) | 1.30 | 12.10 | 29.10 | 0.45 |

**The microphone sets the board width.** Turn it so its 2.65 mm side runs across the board and its 3.5 mm side runs along the length — the other way round it doesn't fit at all.

---

## 4. Does it fit — the arithmetic

**Height, the tight one:**

```
  tallest top part (mic)      0.98
  PCB core                    0.60
  tallest bottom part         0.55
  ------------------------------
  board stack                 2.13
  battery thin step         + 2.60
  ------------------------------
  total                       4.73     cavity 5.40    margin 0.67  ✓
```

**Width:**

```
  widest footprint            3.00  (the decoupling row)
  board                       3.60     margin 0.60  ✓
  board in cavity             3.60     cavity 5.40  margin 1.80  ✓
```

**Length:**

```
  2.50  cap
 14.50  battery only
 13.00  board
  5.00  tip
 ------
 35.00  ✓
```

**Battery:** stepped pouch, 4.8 mm wide — 2.6 mm thick for 13 mm under the board, 4.6 mm thick for 14.5 mm above it. 482 mm³. At 225 Wh/L (measured from Grepow's ultra-narrow cell) that's **29.3 mAh**.

Allow the board to grow to 16 mm once routing is real and you get **27.6 mAh** — plan on that.

---

## 5. Talk time

| Recording draw | Talk time |
| --- | --- |
| 4 mA (optimized firmware) | 5.5 h |
| **6 mA (realistic)** | **3.7 h** |
| 8 mA (typical today) | 2.8 h |

Sanity check: **Oura Ring 4 is 26 mAh** in a smaller cross-section than this. 28 mAh in a 6 × 35 mm bar is not an aggressive claim.

---

## 6. Before you spend money

1. **Quote the stepped cell** (Grepow). Longest lead, only true custom part, and it sets the internal dimensions everything else works around.
2. **Choose the tactile switch.** Needs to be ≤2.5 × 1.6 mm, ≥150 µm travel, and rated for 100k presses.
3. **Prove the antenna** — a chip antenna in a dielectric tip on a 30 mm metal body. The maths is good (30 mm is 98% of an ideal quarter wave at 2.45 GHz) but it is still unproven in this exact geometry, and no arithmetic settles it.
4. **Buy the tube first.** 6 × 6 × 0.3 mm 316L square tube is a catalogue item and costs almost nothing. Hold it before committing to anything else.

**Do not order the custom board or the custom cell until the ugly dev-board version records, transmits, and transcribes.**
