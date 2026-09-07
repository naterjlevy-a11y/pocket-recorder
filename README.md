# Pocket Recorder

A thing in your pocket. Squeeze it, talk, let go. The note is on your phone
before you've put it away.

This repo is the industrial design and the mechanical packaging for that object,
plus a web app that does the software half. **The hardware is designed and
costed, not built.** Everything below says which is which.

---

## Why it isn't an always-on recorder

The AI wearables on sale right now record continuously, and that one decision
drives every other problem they have. It records everyone around you. It forces
a subscription, because transcribing all day is expensive. It forces a battery
big enough to run all day. And it makes people visibly uncomfortable, which
shows up in the reviews.

Deliberate capture is a different object:

| | Always-on pendant | This |
| --- | --- | --- |
| Privacy | records everyone, always | records only while held |
| Battery | must survive a day of recording | idle 99.9% of the time |
| Transcription cost | hours per day | seconds per day |
| Subscription | structurally required | optional |
| Social friction | high | it's a voice memo button |

It is not a smaller version of the always-on thing. It's the voice memo app,
minus unlocking your phone.

---

## The mechanical problem

The whole design is one question: **does it fit in a bar small enough to forget
you're carrying?**

Target is **6 × 6 × 35 mm** in drawn 316L square tube. Working through it:

| | |
| --- | --- |
| Wall thickness | 0.30 mm — thinner is too fragile to carry a button boss |
| Internal cavity | 5.40 × 5.40 mm |
| Board length needed | **26.2 mm**, parts end to end with routing space |
| Caps and accent band | 9 mm |
| Spent before any battery | **35.2 mm** |

That last row is the answer to why the bar isn't 40 mm long and why the battery
is a custom stepped pouch rather than a cell: at 40 mm there is no room left for
power. The battery becomes a 4.6 mm thick step above the board and a 2.6 mm thin
step beneath it, which is what buys **3.7 hours** of talk time at a realistic
6 mA and leaves **0.67 mm** of headroom on the stack.

Every component sits at a real coordinate in [`model/bar.scad`](model/bar.scad),
which renders five ways — assembled, ghost, internals, section, exploded — so
the packing can actually be looked at rather than asserted.

### What went wrong

[`ERRATA.md`](model/ERRATA.md) is an audit of the design against itself. It found
eight errors, three of them serious. The worst:

> **The button does not work. The design is wrong.** The tactile switch is placed
> facing the front face; the pusher enters through the side face. They are
> perpendicular. The pusher would press into empty space beside the switch.

That is a geometry error that survived both the model and the parts document,
and it would have been found by a machinist or by a wasted prototype run. It is
written up rather than quietly fixed because the fix has two options with
different costs, and the choice isn't made yet.

---

## What's in here

| | |
| --- | --- |
| [`model/bar.scad`](model/bar.scad) | The parametric model. Open in OpenSCAD, change `VIEW`. |
| [`model/PARTS-AND-LAYOUT.md`](model/PARTS-AND-LAYOUT.md) | Every part with an order number, at a real coordinate, summed and checked. |
| [`model/FIT-STUDY.md`](model/FIT-STUDY.md) | Whether it fits at 5 mm and 6 mm, and what sets the wall thickness. |
| [`model/ERRATA.md`](model/ERRATA.md) | The audit. Eight errors, three serious. |
| [`model/ASSEMBLY.md`](model/ASSEMBLY.md) | Build order. |
| [`model/SHOPPING-LIST.md`](model/SHOPPING-LIST.md) | What to buy, with confidence marked per line. |
| [`model/renders/`](model/renders) | Outside, inside, sectioned, exploded. |
| [`app/index.html`](app/index.html) | The software half: hold, talk, release, note lands. |
| [`PLAN.md`](PLAN.md) | The product argument and the market it's aimed at. |

## Running the app half

`app/index.html` is a single file with no build step. Open it, or serve the
folder:

```bash
python3 -m http.server 8000 --directory app
```

## Status

Designed, costed and audited. Not manufactured. The parts list carries a
confidence mark per line because the next step spends money.
