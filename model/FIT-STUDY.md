# Fit study — does everything actually go in the box?

Built the box, put every part in it, checked the margins. **Short answer: yes at 6 mm, no at 5 mm, and only if the battery is a flat pouch under the board rather than a round cell behind it.**

---

## 1. The number that drives everything

The circuit board needs **26.2 mm of length**. That isn't negotiable — it's the parts laid end to end with routing space between them:

| On the board | mm |
| --- | --- |
| Processor (nRF54L15) | 2.45 |
| Flash | 2.5 |
| Charger | 1.6 |
| 32 MHz crystal | 1.6 |
| Tactile switch | 2.0 |
| Mic + silicone boot | 3.5 |
| ~12 passives | 6.0 |
| Indicator LED | 1.0 |
| Spacing between parts | 5.6 |
| **Total** | **26.2** |

Add the two end caps and the accent band — **9 mm** — and you've spent **35.2 mm before a single milliamp-hour of battery.**

That's the whole problem with a 40 mm bar.

---

## 2. Wall thickness — 0.3 mm is the answer

| Width | Wall | Cavity | 3.6 mm board fits? |
| --- | --- | --- | --- |
| 5 | 0.2 | 4.6 | yes — but too fragile for a button boss |
| 5 | 0.3 | 4.4 | yes |
| 5 | 0.4 | 4.2 | yes, barely |
| 5 | **0.5** | 4.0 | **NO** |
| 6 | 0.2 | 5.6 | yes — too fragile |
| **6** | **0.3** | **5.4** | **yes, comfortably** |
| 6 | 0.4 | 5.2 | yes |
| 6 | 0.5 | 5.0 | yes |

**0.2 mm is too thin** — the button needs a local thickened boss to hold the O-ring groove, and there's nothing there to thicken. **0.5 mm at 5 mm wide kills the board.** 0.3 mm is a standard drawn-tube size and leaves room for the button.

---

## 3. Layout A — round cell behind the board (what a 60 mm bar does)

The cell and the board sit end to end, so they compete for length directly.

| Width | Length | Battery space | mAh | Days @15 min/day |
| --- | --- | --- | --- | --- |
| 6 | **40** | 4.8 mm | **2.6** | **2** ← dead |
| 6 | 50 | 14.8 mm | 12.0 | 9 |
| 6 | 60 | 24.8 mm | 21.3 | 16 |
| 6 | 70 | 34.8 mm | 30.7 | 23 |
| 5 | 60 | 24.8 mm | 13.2 | 10 |

**At 40 mm this layout is dead** — 4.8 mm of leftover space is about 2 mAh. This layout needs 55 mm minimum.

---

## 4. Layout B — flat pouch *under* the board ← the unlock

A pouch cell 2.6 mm thick slides beneath the board instead of behind it. Board stack is 2.2 mm tall, pouch is 2.6 mm, total 4.8 mm — fits inside a 5.4 mm cavity. **Now they overlap along the length instead of competing for it.**

| Width | Wall | Length | Pouch | mAh | Days @15 min/day |
| --- | --- | --- | --- | --- | --- |
| 6 | 0.3 | **40** | 4.8 × 2.6 × 30 | **15.7** | **12** |
| 6 | 0.3 | 45 | 4.8 × 2.6 × 35 | 18.3 | 14 |
| 6 | 0.3 | 50 | 4.8 × 2.6 × 40 | 20.9 | 16 |
| 5 | 0.3 | 40 | 3.8 × 1.6 × 30 | 7.6 | 6 |
| 5 | 0.3 | 45 | 3.8 × 1.6 × 35 | 8.9 | 7 |

**6 mm × 40 mm gives 15.7 mAh — about 12 days at 15 minutes of talking a day.** That works.

**5 mm gives half that**, because losing 1 mm of width costs 1 mm off *both* the pouch's width and its thickness. Cross-section is squared, not linear — this is why 5 mm keeps failing.

---

## 5. The catch — and the fix

Layout B has one consequence that changes the outside of the product.

The board and battery now span nearly the whole body. But **nothing conductive can cross the antenna gap**, or the two steel halves short together and the radio dies. With the internals filling the body, there's nowhere in the middle to put a split.

**So the RF window moves to the end.** Instead of a thin band at the midpoint, make the **bottom 7 mm a solid black dielectric tip** — ceramic or polymer — with the antenna inside it. The 33 mm metal body above becomes the counterpoise, and at 2.45 GHz a quarter wave is 30.6 mm, so a 33 mm body is very close to ideal for that job.

This is arguably a better-looking object than a thin band: a polished steel bar with a black tip. It also still does every job you wanted:

| You wanted | The tip delivers |
| --- | --- |
| Black accent near the bottom | it *is* the bottom |
| Lets Bluetooth through | it's the antenna window |
| Light can glow through it | translucent polymer + one LED |
| Waterproof but sound passes | ePTFE mesh face over the mic port |

**A thin mid-body band only works with Layout A** — the 55–60 mm version with a round cell. Both are valid; they're just different products.

---

## 6. Recommendation

**6 mm square · 0.3 mm wall · 45 mm long · flat pouch under the board · black dielectric tip at the bottom.**

| | |
| --- | --- |
| Cavity | 5.4 × 5.4 mm |
| Board | 3.6 mm wide, 1.8 mm of margin |
| Battery | 18.3 mAh |
| Runtime | ~14 days at 15 min/day |
| Button | Ø2.6 mm pusher, side face, ~32 mm down |
| Mic | behind mesh, upper third — closest to your mouth |
| Proportion | 7.5:1, close to the 10:1 reference |

45 mm rather than 40 mm buys 17% more battery and better antenna performance for 5 mm nobody will notice. If you want to go longer, every extra 5 mm is roughly 2.6 mAh — about two more days.

---

## 7. Margins, honestly

| Check | Margin | Verdict |
| --- | --- | --- |
| Board width in cavity | 1.8 mm | comfortable |
| Board + pouch stack height | 0.6 mm | tight but real |
| Button boss inside wall | 1.8 mm | fine |
| Mic package width | 2.75 mm | plenty |
| Length budget | 45 − 35.2 = 9.8 mm spare | comfortable |

**The tight one is stack height** — 0.6 mm across board plus battery. That means the pouch must be a specified thickness with a real tolerance, not a generic part. Confirm the exact cell before finalising the tube.

**Still unproven:** whether the antenna radiates well enough out of a dielectric tip on a 33 mm metal body. That remains Phase 0 and no amount of arithmetic settles it.
