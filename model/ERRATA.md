# Errata — audit of the whole design, 2026-08-05

Eight errors found. Three are serious. Nothing below is an excuse; where I don't have a solution I say so.

---

## SERIOUS — must be fixed before spending money

### 1. The button does not work. The design is wrong.

In `bar.scad` the tactile switch is placed with `up=true`, which puts it facing the **front** face (+Z). The pusher enters through the **side** face (+X). They are perpendicular. **The pusher would press into empty space beside the switch.**

This is a real geometry error in the model and in `PARTS-AND-LAYOUT.md`, which shows the button on the side face and the switch on the board's top side.

**Solution:** the switch and the pusher must face the same direction. Two options:

- **Move the button to the front face**, alongside the mic port. Both features then sit on one face at different heights (mic at 19 mm, button at 22 mm). Simplest fix, no new parts.
- **Rotate the board 90°** inside the tube so its component side faces sideways. Then the mic port moves to the side face too.

Recommended: put the button on the front face. But note this contradicts the ergonomics I argued for earlier — pinching the bar puts your thumb on the *side*, not the front. **A decision is needed, and it changes the industrial design.**

### 2. The Phase 0 antenna test as written is impossible

Cart 1 says to put the XIAO nRF52840 Sense inside a 6 mm tube.

```
XIAO nRF52840 Sense : 21.0 x 17.5 x 3.5 mm
6 mm tube cavity    :  5.4 x  5.4 mm
Does not fit — off by 12.1 mm
```

The dev board is three times too wide. The test I told you to run cannot be performed with the parts I told you to buy.

**Solution:** the test must feed radio energy *into* the tube from outside, over a thin coaxial cable. That requires a board with an external antenna connector (u.FL / IPEX), which the XIAO does not have.

- Buy an **nRF52840 module or dongle with a u.FL connector** (Fanstel BT840F, or a Raytac MDBT50Q-RX dongle in the external-antenna variant) instead of relying on the XIAO for this test.
- Solder a thin coax (RG-178 or 1.13 mm) to the split tube, feed it from that board, and measure received strength on a second board across the room.

The XIAO is still the right part for the *recording* prototype (Phases 1–3). It is the wrong part for the antenna test.

### 3. There is no battery protection in the BOM, and it costs length I have not budgeted

A lithium cell needs protection against over-discharge, over-current and short circuit. My parts list has none. The nPM1100 protects the *charging* path; it is not a substitute for cell protection on the cell itself.

Custom pouch cells normally ship with a small protection board (PCM) welded to the tabs, typically **3–5 mm long**. My 35 mm budget assumed a bare cell with no PCM.

**Consequence:** the bar grows to roughly **38–40 mm**, or the battery shrinks by 3–5 mm of length (about 4–6 mAh, so roughly 30–45 minutes of talk time).

**A solution must be found, and it is a real trade:** either accept ~39 mm, accept less runtime, or ask Grepow whether the PCM can be folded beside the cell rather than sitting in line with it. I do not know the answer to the third option — it has to be a question in the quote request.

---

## REAL, BUT MANAGEABLE

### 4. Charge current is at the limit of the cell

nPM1100's minimum selectable charge current is **20 mA**. On a 28 mAh cell that is **0.71C**.

Many small pouch cells accept 1C, so this is probably fine — but "probably" is not verification. **Confirm the cell's maximum charge current in the Grepow quote.** If it is below 20 mA, the nPM1100 cannot charge it slowly enough and a different PMIC is required.

### 5. I contradicted myself on the board's layer count

I wrote "4-layer rigid-flex" in `PARTS-AND-LAYOUT.md` and the 3D viewer, and "6-layer HDI" elsewhere.

**6-layer HDI is correct.** The nRF54L15 CSP has 0.3 mm ball pitch, and Nordic's own guidance is explicit that there is no escape routing for these packages on ordinary boards — it needs laser microvias and via-in-pad. The 4-layer figure is wrong and would make the board cheaper than it will actually be.

### 6. The talk-time figure may be optimistic by 2×

I quoted **3.7 hours**, based on a 6 mA recording draw. That number is my estimate of a well-optimised design, not a measurement.

| Draw | Talk time |
| --- | --- |
| 4 mA — optimistic | 5.6 h |
| 6 mA — what I quoted | 3.7 h |
| **13 mA — what Plaud and Omi actually draw** | **1.7 h** |

Shipping products in this category draw 11–16 mA. If the firmware lands there rather than where I assumed, you get **1.7 hours, not 3.7**. That is still a usable product, but it is half what I told you.

**This can only be settled by measurement**, in Phase 1, on the dev board. Until then treat 1.7–3.7 hours as the honest range.

### 7. Two charge pads means no way to program the device after assembly

I specified 4 contacts early on, then cut to 2 when audio moved to Bluetooth. With only power and ground, there is no debug connection once the board is inside the tube.

**Solution:** go back to **4 pads** — power, ground, and the two programming lines (SWDIO/SWCLK). The cost is nothing; the alternative is that any firmware problem after assembly leaves you with a sealed brick, and over-the-air updates cannot recover a device whose radio code is broken.

### 8. My own documents describe two different products

`PENDANT-PLAN.md` describes a **thin black band across the middle** at 28 mm, splitting the bar into a dipole. `FIT-STUDY.md`, `PARTS-AND-LAYOUT.md`, the CAD model and the 3D viewer all describe a **5 mm black tip at the bottom** with a chip antenna inside.

These are incompatible designs and both are in your project folder. The tip version is the current one — it followed from the stacked-battery layout, which leaves no room for a mid-body split. `PENDANT-PLAN.md` is out of date and needs rewriting.

---

## What still has no answer

**Whether the antenna radiates at all.** Unchanged, and unaffected by everything above. A chip antenna in a 5 mm dielectric tip on a 30 mm metal body is sound in theory — 30 mm is 98% of an ideal quarter wave — but it is unproven in this geometry, and no amount of calculation settles it. It remains the one thing that can invalidate the whole product.

---

## Revised honest summary

| | Was | Now |
| --- | --- | --- |
| Length | 35 mm | **38–40 mm** once cell protection is included |
| Talk time | 3.7 h | **1.7–3.7 h** until measured |
| Board | 4-layer | **6-layer HDI** — more expensive |
| Button | side face | **unresolved** — front face works, side face needs a redesign |
| Charge pads | 2 | **4** |
| Antenna | unproven | unproven |

None of this makes the product impossible. All of it would have surfaced later and more expensively.
