# Shopping list — checked for compatibility

Two carts. **Only order Cart 1 now.** Cart 2 is the production BOM and buying it today would waste money — those chips are 2 mm across with solder balls underneath and cannot be hand-soldered or used without a fabricated board.

---

## ⚠ Compatibility problem found — the BOM changed

**A lithium battery charges to 4.2 V. The nRF54L15's absolute maximum is 3.6 V.** You cannot run the chip from the battery directly; it would be destroyed on the first full charge.

The BQ25100 I listed earlier is a *charger only* — it manages charging but passes raw battery voltage through. It needs a separate regulator plus an inductor to step the voltage down.

**Fix: swap it for the Nordic nPM1100.** One 2.1 × 2.1 mm chip that is both the charger *and* a step-down regulator, with the output selectable at 1.8 / 2.1 / 2.7 / 3.0 V. It replaces two parts, solves the voltage problem, and is made by the same company as the main chip so they're designed to work together.

### Voltage rail — everything must agree

| Part | Works at | Notes |
| --- | --- | --- |
| nRF54L15 | 1.7 – 3.6 V | 1.8 V is uncomfortably close to its floor under load |
| T5837 mic | 1.6 – 3.6 V | happy either way |
| W25Q128J**W** flash | 1.65 – 1.95 V | **1.8 V part only** |
| W25Q128J**V** flash | 2.7 – 3.6 V | **3.3 V part** |

**Run the rail at 3.0 V and use the "JV" flash.** More headroom above the chip's minimum than 1.8 V gives you.

> **Verify before ordering:** confirm the JV is available in the 2.5 × 2.5 mm WLCSP package. If it's only offered in the larger package, drop the rail to 1.8 V and use the JW instead. **The rail and the flash must match** — a 1.8 V flash on a 3.0 V rail is destroyed instantly.

---

## Cart 1 — order today · ~$180 · arrives in days

Everything needed to answer the three questions that can kill the project. Nothing here is exotic.

| # | Item | Where | ~$ | Why |
| --- | --- | --- | --- | --- |
| 1 | **Seeed XIAO nRF52840 Sense** | [Seeed](https://www.seeedstudio.com/Seeed-XIAO-BLE-Sense-nRF52840-p-5253.html) · also Digi-Key, Amazon | 20 | Bluetooth chip, **microphone and battery charging already on it**. This is your whole prototype. |
| 2 | **Second XIAO or nRF52840 Dongle** | [Nordic dongle](https://www.nordicsemi.com/Products/Development-hardware/nRF52840-Dongle) · Digi-Key | 10–20 | The receiver, so you can measure signal strength through the steel. Without this the antenna test is guesswork. |
| 3 | **K&S 6 mm square brass/aluminium tube** | hobby shops · [Amazon](https://www.amazon.com/s?k=K%26S+precision+metals+square+tube+6mm) | 8 | The test enclosure. Brass behaves like steel for radio purposes and is far easier to cut. |
| 4 | **LiPo 3.7 V, 100–150 mAh** | Adafruit, Amazon | 8 | Runs it untethered. |
| 5 | **SMD/through-hole tactile switch assortment** | Amazon, Digi-Key | 8 | You'll want to feel several before picking one. |
| 6 | **PTFE or nylon rod, 6 mm** | Amazon, McMaster | 8 | The insulating gap that makes the antenna work. |
| 7 | **Digital calipers** | Amazon | 25 | Non-negotiable. Every number in this project is a fraction of a millimetre. |
| 8 | **The reference pendant, 40 × 4 mm** | The Steel Shop | 40 | Hold the size in your hand before committing to 6 mm. |
| 9 | Thin silicone sheet + fine mesh | Amazon | 12 | Mic mounting and port tests. |
| 10 | Chain and bails | **your Vancouver wholesale contact** | ~0 | Ask for ~4 mm rolo, and a leather cord to compare. |

**Buy 1, 2, 3 and 6 first if you want to move fastest** — that's the antenna test, and everything else waits on its answer.

---

## Cart 2 — production BOM · DO NOT ORDER YET

Correct and checked, so it's ready when the board is designed. These parts only become useful once you have a fabricated PCB and an assembly house.

| Part | Order number | Package | Source | Note |
| --- | --- | --- | --- | --- |
| SoC + BLE | **NRF54L15-CAAA-R** | CSP47, 2.45 × 2.25 | [Digi-Key](https://www.digikey.com/en/products/detail/nordic-semiconductor-asa/NRF54L15-CAAA-R) · Mouser | 0.3 mm pitch — needs HDI board and machine assembly |
| PMIC | **NPM1100-CAAA-R** | WLCSP 2.1 × 2.1 | [LCSC ~$0.91](https://www.lcsc.com/product-detail/Battery-Management-ICs_Nordic-Semicon-NPM1100-CAAA-R_C3682247.html) · Digi-Key | charger + buck. Set to 3.0 V |
| Microphone | **T5837** | 3.5 × 2.65 × 0.98 | [TDK](https://invensense.tdk.com/products/digital/t5837/) · Digi-Key | digital, no audio chip needed |
| Flash 16 MB | **W25Q128JV** (WLCSP) | 2.5 × 2.5 | Digi-Key, LCSC | **confirm package + 3.0 V match** |
| Crystal 32 MHz | **NX1612SA-32MHZ** | 1.6 × 1.2 | [JLCPCB C1986486](https://jlcpcb.com/partdetail/NDK-NX1612SA_32MHZ_EXS00ACS09166/C1986486) | no load caps needed — built into the SoC |
| Antenna | **2450AT18A100E** | 3.2 × 1.6 × 1.3 | Johanson · Digi-Key | goes in the black tip |
| Mic vent | **GORE GAW334** | Ø1.6 | Gore (sales enquiry) | IP68, <2 dB loss |
| Tactile switch | ≤2.5 × 1.6 mm | — | Digi-Key/Mouser filter | **still to choose** |
| Battery | Grepow custom stepped | 4.8 wide, 2.6/4.6 | [Grepow](https://www.grepow.com/shaped-battery/pouch-stepped-lipo-battery.html) | **quote now — longest lead item** |
| Passives | 0201 + 0402 inductor | — | LCSC (cheapest by far) | pennies |

### Compatibility summary

| Check | Result |
| --- | --- |
| Battery voltage vs SoC maximum | **was broken — fixed by the nPM1100** |
| Rail voltage across SoC, mic, flash | agree at 3.0 V (verify flash package) |
| Mic interface to SoC | digital PDM, native — direct connection |
| Flash interface to SoC | SPI, native |
| Crystal load capacitors | built into the SoC — 2 parts saved |
| Every part fits the 5.4 mm cavity | yes, 0.67 mm headroom |
| Antenna vs metal case | **unproven — this is Phase 0** |

---

## Cheapest and fastest, honestly

**Fastest:** Digi-Key and Mouser ship next-day to Canada and stock nearly everything in Cart 2. Amazon is fastest for the tube, calipers and silicone.

**Cheapest:** LCSC is dramatically cheaper for chips and passives (the nPM1100 is under a dollar there) but ships from China — a week or two, plus customs. Use LCSC when you order the real BOM; use Digi-Key/Amazon now, because a week of waiting costs more than a few dollars saved.

**JLCPCB** is worth knowing about for later: they fabricate *and* assemble boards, stock many of these parts themselves, and are far cheaper than assembling elsewhere. That's the Phase 4 route.

---

## The order to do things

1. **Order Cart 1 items 1, 2, 3, 6** today — about $56, arrives this week.
2. **Email Grepow for a stepped-cell quote** the same day. It costs nothing and it's the longest lead item in the project.
3. **Build the antenna test.** If Bluetooth can't escape the metal, everything else changes and you've spent $56 finding out.
