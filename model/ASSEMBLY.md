# The Bar — assembly model

How it actually goes together. Numbers verified; the stack closes.

3D model: `bar.scad` — open in [OpenSCAD](https://openscad.org) (free), press F5. Change `VIEW` at the top for `assembled` / `exploded` / `section` / `internals` / `dock`.

---

## 1. The layout, and why it's this order

```
   ○  chain bail (solid, part of the cap)
 ┌───┐  0.0
 │CAP│  top cap ........................ 4.0 mm
 ├───┤  4.0
 │   │
 │BAT│  battery bay ................... 24.0 mm   ← upper half
 │   │
 ├───┤  28.0
 │▓▓▓│  BAND — antenna gap + light ..... 2.5 mm   ← the split
 ├───┤  30.5
 │ ◉ │  mic + mesh at 34 mm
 │PCB│  electronics bay ............... 25.1 mm   ← lower half
 │ ● │  button at 45 mm
 ├───┤  55.6
 │CAP│  bottom cap + charge pads ....... 4.0 mm
 └───┘  59.6  (+0.4 assembly clearance = 60)
```

**Why the battery is on top and the electronics are at the bottom** — this is the one non-obvious decision, and it's forced by the antenna.

The band splits the steel into two electrically separate halves. That's the entire point: the two halves become the two arms of the antenna. But it means **nothing conductive can bridge the gap**, or the two halves short together and the antenna dies. A PCB running the full length with a ground plane would do exactly that.

So: all electronics live entirely in the lower half. The battery lives entirely in the upper half. Only **two thin wires** cross the gap, each with a ferrite bead that blocks radio frequencies while passing DC. This is precisely the approach in Oura's antenna patent (US 11,349,191).

Three things fall out of that for free:

- The **button lands in the lower third** — exactly where you wanted it, and where your thumb naturally sits on a hanging pendant.
- The **charge pads are next to the charging circuit**, so no power routing crosses the gap.
- The **band sits at 28 mm**, giving antenna arms of 28 and 32 mm. Near-symmetric is the easiest case to match.

**Cost of moving the band lower:** at 40 mm you get 40/20 mm arms. It still radiates, but the feed impedance climbs and you need a proper matching network — call it 1–3 dB. Decide this with your eyes; just know it isn't free.

---

## 2. Cross-section — the 6 mm is mostly wall and air

```
        6.00 mm
   ┌──────────────┐
   │░░░░░░░░░░░░░░│  0.4 wall
   │░┌──────────┐░│
   │░│          │░│  cavity 5.2 × 5.2
   │░│  ▄▄▄▄▄▄  │░│  PCB 3.6 wide
   │░│          │░│
   │░└──────────┘░│
   │░░░░░░░░░░░░░░│
   └──────────────┘
```

| Needs | Width | Fits in 5.2 | Margin |
| --- | --- | --- | --- |
| Battery cell | Ø4.5 | yes | 0.70 |
| PCB | 3.6 | yes | 1.60 |
| Button boss + O-ring | 3.6 | yes | 1.60 |
| Mic package | 2.65 | yes | 2.55 |

Everything clears. The battery is the tight one — 0.7 mm of total slack means the cell needs a thin heat-shrink sleeve and nothing else.

---

## 3. The band does three jobs

One part, three functions — which is why it's worth the manufacturing trouble.

**1 · It's the antenna.** Without a non-metal gap, a sealed steel tube attenuates Bluetooth about 6 dB per millimetre. The radio isn't weak, it's silent. The gap turns the case into the antenna.

**2 · It's the recording light.** Make the band from a *translucent* polymer or ceramic and put one LED inside against it. The entire ring glows when recording — visible from every angle, no extra hole in the case, no window to seal. Cost: one LED and one resistor.

This is the answer to "should there be a light." A hole for an LED would breach the waterproofing; the band is already a non-metal window, so it's free.

**3 · It's the design accent.** A dark or coloured ring across polished steel, near the lower third. Exactly the detail you described — and now it's structural, functional, and decorative at once.

**Material:** a translucent glass-filled polymer bonded by nano-moulding (NMT), which also forms the waterproof seal. Zirconia is the premium alternative but is only faintly translucent — less good as a light pipe.

**Structurally it's fine.** The chain pulls on the *top* cap, so the band only ever carries the weight of the lower half — about 5 grams. It is not in the main load path.

---

## 4. The button

| Piece | Spec |
| --- | --- |
| Pusher | Ø2.6 mm steel, flush with the face when idle |
| Travel | 0.25 mm |
| Seal | Ø0.45 mm O-ring in a groove around the pusher |
| Switch | SMD tactile dome on the PCB directly beneath |
| Position | side face, 45 mm from top |

Ø2.6 mm on a 6 mm face leaves 1.7 mm of steel each side — proportionally it reads as a deliberate detail rather than a hole.

**Interaction, as you specified:**

| Input | Result |
| --- | --- |
| Single click | **nothing** — deliberate, so a bump against a desk can't start a recording |
| Double click | starts recording, band glows. Click again to stop |
| Press and hold | records while held, stops on release |

Both modes are firmware only — no extra parts.

**Side, not the bottom end.** A pendant hangs free, so pressing the bottom just swings it or tugs the chain. On the side you pinch it — thumb on the button, finger behind as backing — which is a stable, one-handed, eyes-free gesture.

---

## 5. Microphone

Port Ø1.2 mm on the front face at 34 mm, just below the band, with a Ø2.6 mm mesh disc recessed 0.25 mm so it sits flush.

The mesh is the Gore ePTFE membrane — waterproof to IP68, under 2 dB of acoustic loss — and it reads as an intentional design mark, not a hole.

**Why the mic is in the lower half, not up near your mouth:** it has to be on the same side of the band as the chip. Moving it 30 mm lower adds about 10% to the mouth-to-mic distance, which is roughly **1 dB** — inaudible. Routing four microphone signals across the antenna gap would cost far more than that.

The mic sits in a silicone boot so it never touches steel. Without that the whole bar behaves as a contact microphone and every chain link tick is louder than your voice.

---

## 6. Charging

**On the pendant:** two Ø1.6 mm gold pads on the bottom cap. Only two are needed — audio leaves over Bluetooth, so the dock carries power only.

**The dock:** a weighted block with a shallow channel milled to the bar's profile. Drop the bar in, magnets pull it onto the pins, the chain drapes over a relief notch. No cable to plug, no orientation to get right, nothing to align.

That matches the ritual you described — chain off, drop it in the dish, it charges.

Keep the pads **unpowered until the dock senses a valid load**. A permanent DC voltage across two exposed pads will electrolytically pit them within weeks of sweat exposure.

---

## 7. Assembly sequence

The order matters — some steps are irreversible.

1. **Populate and test the PCB flat**, before anything goes near a tube. Verify recording and Bluetooth on the bench.
2. **Bond the mic** to its silicone boot; fold the flex tail.
3. **Solder the battery tabs** directly to the board. Two wires with ferrite beads bridge what will become the band gap. No connectors anywhere.
4. **Fit the pusher and O-ring** into the lower tube; check the click through the wall.
5. **Slide the electronics into the lower tube** from its open top end, aligning the switch under the pusher.
6. **Bond the band** to the lower tube; seat the LED against it.
7. **Slide the battery into the upper tube**, then bond the upper tube to the band.
8. **Seal the mic mesh** over its port.
9. **Bond both end caps** last. From here it's a closed object with no service access.
10. **Test submerged** before calling it done.

**There is no rework path after step 9.** Everything that can be tested must be tested before the caps go on.

---

## 8. What is most likely to go wrong

| Risk | Why | What to do |
| --- | --- | --- |
| **Antenna doesn't radiate** | untested; depends on your exact build | Phase 0, before anything else |
| Band joint fails | it's a bonded butt joint in a thin wall | mechanical interlock, not adhesive alone |
| Button leaks | O-ring gland is tight in a 6 mm boss | pressure-test 20 units before committing |
| Cell doesn't fit | 0.70 mm total slack | buy the exact cell before finalising the tube |
| Chain noise | metal bar on metal chain | silicone mic boot; offer leather |
| No service access | fully bonded | accept it — this is a sealed product |

---

## 9. Model status

`bar.scad` is written but **not yet rendered** — OpenSCAD isn't installed on this machine, so the geometry hasn't been visually confirmed. Install with:

```
brew install --cask openscad
```

Then open the file and press F5. Print `VIEW = "assembled"` at 1:1 in resin to hold the real size before ordering any steel.
