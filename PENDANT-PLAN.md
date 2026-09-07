# The Bar — plan

**One line:** a slim steel bar on a chain. It looks like jewellery. Tap it, talk, let go.

Supersedes the pocket form factor in `PLAN.md`. The thesis, the software half, and the legal notes there still hold.

---

## 1. The thesis: Ray-Ban Meta logic

You walked into a Ray-Ban store with $430 wanting nice glasses. You left with smart glasses. **The tech was a bonus discovered after the object had already won.**

That is the entire strategy. Every competitor inverts it — they build a gadget, then try to make it wearable.

| | Them | This |
| --- | --- | --- |
| First impression | "what's that device?" | "nice chain" |
| Bought because | it records | it looks good |
| Worn when | you remember to | always, it's your chain |
| Off-mode | looks like a gadget | looks like jewellery |

**The test:** someone should be able to wear it for a week before anyone asks what it is. If it fails that, nothing else in this document matters.

Corollary: **it must look complete with the electronics dead.** A bar with a seam, a visible port, or a blinking LED is a gadget. Battery flat, it still has to read as a $200 chain.

---

## 2. The object

```
         ○ ── stainless chain (or leather cord)
         │
       ╔═╧═╗
       ║   ║   6 × 6 mm square section
       ║   ║   60 mm long
       ║   ║   brushed or polished 316L
       ║   ║   no visible seam, no port, no LED
       ╚═══╝
```

| Spec | Target | Note |
| --- | --- | --- |
| Section | **6 × 6 mm** | 5 mm is possible — see §4. 6 mm is the shippable one |
| Length | 55–65 mm | also happens to be a λ/2 antenna at 2.4 GHz |
| Weight | 12–18 g | heavy enough to feel real, light enough to forget |
| Material | 316L steel v1, titanium v2 | drawn square tube, not machined |
| Finish | brushed + polished SKUs | |
| Water | **IP68** | the differentiator — see §5 |
| Cord | steel chain **or leather** | leather is quieter, see §6 |

**Chain lug is a machined solid end cap, never a hole in the tube wall.** At 0.3 mm wall that's where a yanked necklace fails.

### 2a. The reference object — real dimensions

**"Slim Bar Pendant", stainless steel: 40 mm long × 4 mm wide. Shiny finish. 10:1 ratio.**

That's the target aesthetic, confirmed from the spec sheet rather than estimated. It is smaller than it looks in the worn photo.

**4 × 4 × 40 mm cannot hold this product.** At 0.3 mm wall the cavity is 3.4 mm, and the minimum PCB width is 3.3 mm — 0.05 mm of clearance per side, before an insulating liner. There is no room for a battery *beside* the board, only end-to-end, which leaves ~11 mAh. That's Oura-ring capacity, and Oura isn't recording audio.

**The move is to scale the object, not change its proportion.** The 10:1 ratio is the look; hold it and grow.

| Outer | Cavity | Battery | Ratio | |
| --- | --- | --- | --- | --- |
| 4 × 4 × 40 | 3.4 | ~11 mAh | 10:1 | ← the reference. Unbuildable |
| 4 × 4 × 55 | 3.4 | ~23 mAh | 14:1 | too spindly, board still impossible |
| 5 × 5 × 55 | 4.4 | ~38 mAh | 11:1 | aggressive but real |
| **6 × 6 × 60** | **5.4** | **~67 mAh** | **10:1** | **← same proportion, 1.5× scale** |
| 7 × 7 × 50 | 6.4 | ~66 mAh | 7:1 | reads stubby |

**Target: 6 × 6 × 60 mm.** Identical 10:1 proportion to the pendant you picked, uniformly scaled 1.5×. It should read as *the same object*, because geometrically it is one — and it carries 6× the battery of the 4 mm version.

Millimetre intuition:

| | |
| --- | --- |
| 4 mm | the reference — a stack of ~5 credit cards |
| 5 mm | thinner than a drinking straw |
| **6 mm** | **a drinking straw** |
| 8 mm | an iPhone's thickness; an Apple Pencil is 8.9 |

**Buy the actual pendant ($40) before deciding.** Hold 4 mm in your hand, then hold a 6 mm steel tube next to it. This decision should be made physically, not from a table.

**Other things the photo settles:**

- **Square section confirmed.** Two faces catch light differently — one bright, one shadowed — with a crisp edge between. It reads as a machined bar, not a round rod. Preserve that edge; it's what makes it look intentional rather than like tubing.
- **Length-to-width ratio is ~8:1.** That proportion *is* the look. Get thicker without getting longer and it becomes a USB stick.
- **It hangs from a small bail and swings freely.** It is not a fixed link in the chain. Free-hanging is the correct choice — a rigid link would fight the body and telegraph "device."
- **The chain is delicate relative to the bar.** ~4 mm links against a 7 mm bar. A heavier chain would make it look like hardware.
- **No seam, no port, no hole anywhere on the visible faces.** Everything — mic port, contacts, antenna break — has to live on the rear face or the end caps.

---

## 3. Interaction

No screen. No LED you can't see on your own chest. Two haptic ticks are the entire UI.

```
tap ──────▶ tick ──▶ recording ──▶ release ──▶ tick ──▶ synced
double-tap ▶ tick tick ──▶ hands-free, records until tapped again
```

**Input is an accelerometer, not a touch sensor.** This is settled by physics, not preference: capacitive and inductive touch-on-metal both work by sensing the metal *flex* under your finger. A 3.5 mm button in a 0.5 mm steel wall deflects **28 nanometres** — about 180× below the detection floor. Those are appliance-panel technologies and they do not scale to a 6 mm bar.

An **ST LIS2DW12** (2 × 2 mm, <1 µA) has a hardware single-tap and double-tap engine that runs while the main chip sleeps. It gives you exactly the interaction you described, and a rigid metal bar is the *best* case for it — metal transmits the tap impulse cleanly. Oura went the same way on titanium rather than fight capacitive sensing.

Free bonus: the mic can confirm taps acoustically. Two-sensor agreement ≈ no false triggers in a pocket or under a coat.

---

## 4. How thin can it actually go

**5 mm is real.** Oura Ring 4 is 7.9 × 2.88 mm — a *smaller* cross-section than 5 × 5 — fully titanium, BLE, 100 m water resistance. Your bar has more internal volume than an Oura ring.

The unlock is **don't machine it, buy tube.** 5 × 5 mm drawn stainless square tube at 0.3 mm wall is a catalogue item (the medical-needle industry stocks it by the mile). That gives a 4.4 × 4.4 mm cavity — 1.12 cm³. Machining titanium to those walls is specialist work; buying tube is not.

| | 5 mm | **6 mm** | 7 mm |
| --- | --- | --- | --- |
| Battery | 32–40 mAh | **~50 mAh** | 70–90 mAh |
| Off-the-shelf cell? | **no — 50–100k MOQ** | **yes** | no |
| PCB | 6-layer HDI, via-in-pad | 4-layer | 4-layer, easy |
| Days @ 45 min/day | ~4 | ~6 | 8–10 |

**One thing forces 6 mm: battery supply.** Below ~4.5 mm cell diameter nothing exists off the shelf except Panasonic 16 mAh pin cells. A custom cell means a 50,000-unit minimum order — a business constraint, not a physics one.

**Decision: prototype at 5 mm to prove the antenna, ship at 6 mm.** On a 60 mm bar nobody perceives the millimetre, and 6 mm is still slimmer than every competitor (Plaud NotePin's *smallest* dimension is 11 mm).

---

## 5. The obstacles, ranked honestly

### 🔴 1. The metal case is a Faraday cage — this is the whole project's risk

A sealed metal tube does not let BLE out. The cavity is a waveguide operating **14× below cutoff**, attenuating **~6 dB per millimetre**. An antenna 5 mm inside the tube is 30 dB down. It is not weak, it is disconnected.

**"Put a chip antenna inside and add a small window" is dead on arrival.** The required RF aperture at 2.4 GHz is roughly half a wavelength — 62 mm. That is the whole product. The window can't be a patch; it has to be the device.

**The fix — the metal becomes the antenna:**

```
╔═════════╗ ← 30 mm steel  ┐
║         ║                │ half-wave dipole,
╠═════════╣ ← 1–2 mm ceramic/NMT band, fed across
║         ║                │ 61 mm ≈ λ/2 at 2.45 GHz
╚═════════╝ ← 30 mm steel  ┘
```

Split the bar, feed differentially across an insulating band. Same architecture as the iPhone 4 frame. Published metal-cased smart-jewellery research measures 68 % efficiency free-space, 27 % worn on a body.

The insulating band can be made by **NMT** (plastic injected into nano-etched metal) which produces the RF break *and* the waterproof seal in one operation.

**Budget for 2–3× range loss vs a plastic case.** Fine for a phone in your pocket. Not fine if you want 10 m. And skin contact detunes it — plan a thin dielectric coating so the radiator never touches you galvanically.

**Prototype this first. Before industrial design, before firmware.** If the split-bar antenna doesn't work, the product is plastic and the whole premise changes.

*Read: Oura patent US 11,349,191 — they make the battery housing itself the radiator.*

### 🟠 2. Battery: 50 mAh is the whole budget

Only push-to-talk makes this possible. Always-on at 5–6 mm would need charging twice a day — that is why every always-on competitor is a fat pendant.

| | |
| --- | --- |
| Standby (~45 µA) | weeks |
| 45 min recording/day | ~6 days |
| Continuous recording | ~5 h |

Storage caps at **32 MB NOR** (no SPI NAND package is small enough) ≈ 3 h of Opus. Conveniently matches the battery, so the design is self-consistent.

### 🟠 3. The microphone, dangling on your chest

Three separate problems:

**a. Structure-borne chain noise.** A metal bar rigidly coupled to a metal chain is a *contact microphone for the chain*. Every link tick goes straight into the diaphragm, louder than your voice.
→ **Never hard-mount the mic.** Suspend it on a compliant silicone boot. Highest-leverage mechanical decision in the build.
→ **Offer a leather cord SKU.** It is dramatically quieter than steel, and it's a legitimate second aesthetic rather than a compromise.

**b. Distance and off-axis.** Sternum to mouth is ~25–30 cm, and the mouth is above and behind. The physics is fine — 69 dB SPL at 30 cm against a 65 dBA-SNR mic is ~40 dB SNR before room noise. The losses are chin/chest shadowing and clothing rustle, not mic sensitivity.
→ **Two mics ~40 mm apart with beamforming** (a wearable array demonstrates ~16.5 dB SNR gain on the wearer's voice). Port angled up.

**c. The acoustic port.** A long narrow tunnel through thick metal becomes a resonator that wrecks the speech band.
→ **0.3 mm drawn tube makes this a non-issue** — Helmholtz lands at ~33 kHz, out of band. Bond the mic directly to the port with a thin gasket. Every extra millimetre of standoff makes it worse.

**Push-to-talk does the rest for free.** The mic is live only while you're deliberately holding still to speak. An always-on device has to survive a jog; this only has to survive standing still for 20 seconds. Gate on the IMU you already have — flag noisy segments rather than silently producing garbage.

### 🟡 4. Charging — you're right about the ritual, wrong about the technology

Your instinct is correct: **people already take chains off at night.** Drop it in a dish, it charges. That ritual is the product's charging story and it's better than a cable.

But true wireless is the wrong way to get it:

| | Verdict |
| --- | --- |
| **Qi** | dead — smallest coils are 10–13 mm, and the metal body kills it |
| **NFC-WLC** (ROHM ML7670, 13.56 MHz) | exists, built for smart rings, but needs ferrite shielding that eats 0.3 mm of a 4.4 mm cavity, and competes with the antenna for the same dielectric window |
| **Magnetic dock + contacts** | **✓ same ritual, a fraction of the risk** |

**A magnetic cradle delivers the exact UX you described** — plop it down, it snaps and charges — with none of the coil problems. Oura ships **exposed charging contacts at 100 m water resistance**, so contacts are not a sealing compromise. Gold or rhodium plating (sweat drives electrolysis on cheap plating), and keep the pads unpowered until the dock detects a valid load.

Bonus: make them **4 contacts** and the dock also becomes your high-speed data offload — 32 MB in ~2 minutes, instead of pushing audio through a metal-attenuated BLE link.

### 🟡 5. Waterproofing — nobody in this category has done it

Limitless Pendant: IP54. Plaud NotePin: no IP rating, explicitly not submersible. **This is an open differentiator**, and it's the difference between "take it off before the shower" and "never think about it."

Parts are off the shelf: **Gore GAW334** acoustic vent, 1.6 mm, IP68-rated, <2 dB loss at 1 kHz. Seam by NMT bond or adhesive plus full epoxy potting — Oura hits 10 ATM with glued shells. **Avoid O-rings**; there's no room for a gland in a 0.3 mm wall.

### 🟡 6. Recording law

Unchanged from `PLAN.md` §8. Canada is one-party. California, Washington, Illinois, Florida are all-party consent. Deliberate self-capture is the safe case — get the marketing copy right before shipping, not after.

---

## 6. Architecture

```
   ┌── end cap + chain lug (machined solid) ──┐
   │  [ mic A ]                               │  ← compliant boot, ported up
   │  ═══════════════════════════════════════ │
   │  [ nRF54L15 ][ flash ][ LIS2DW12 ][ PMIC ]│  ← 3.5 mm rigid-flex, 4-layer
   │  ═══════════════════════════════════════ │
   │  [ ~50 mAh cell ]                        │
   │  [ mic B ]                               │  ← beamforming pair
   └── ceramic/NMT band = antenna feed ───────┘
          └─ 4 pogo pads on rear face ─┘
```

| Function | Part | Size |
| --- | --- | --- |
| SoC | **Nordic nRF54L15** CSP47 | 2.45 × 2.25 mm |
| | *(nRF52840 WLCSP is 3.5 × 3.6 — too wide. Different chip from `PLAN.md`.)* | |
| Mic ×2 | TDK T5837, flex tail, adhesive-bonded to port | 3.5 × 2.65 × 0.98 |
| Storage | Winbond W25Q128JW WLCSP (16 MB) or MX25U256 (32 MB) | 2.5 × 2.5 |
| Input | ST LIS2DW12 tap engine | 2.0 × 2.0 |
| Power | Nordic nPM1100 | 2.1 × 2.1 |
| Codec | Opus 16 kHz mono, ~20 kbps (nRF54L15 has the RAM; nRF52 didn't) | — |
| Antenna | split-bar dipole fed across ceramic band | — |
| I/O | 4 pogo pads: charge + offload | — |

**Wiring principle: the chain load never reaches a solder joint.** Board floats on a compliant mount inside the tube; lugs tie into machined end caps. Watch-case logic.

**Store and forward, never stream.** BLE carries control and status only — a few hundred bytes that punch through a marginal metal link fine. Audio goes over the dock. A dropped connection mid-sentence must never cost a note.

---

## 6a. The app

**Design goal: the ideal number of app opens per day is zero.** The bar captures, the phone routes, the note lands where it belongs. The app is a safety net you check occasionally — not a destination. Every screen below exists for when something went wrong or you want to look back.

This is the opposite of Plaud, whose app *is* the product and where every note is a trip into their walled garden.

### The happy path — no app involved

```
tap ─▶ "note to self, order the L298N" ─▶ release
  │
  ├─ device: encode, write to flash, BLE notify "1 pending"
  │
  ├─ phone wakes in background (no unlock, no open)
  │    pull audio ─▶ transcribe on-device ─▶ clean ─▶ parse routing phrase
  │
  └─ lands in Apple Notes. Silent. ~10 s after you stopped talking.
```

You never saw a screen. That's the product.

### Screens

**1. Inbox** — the default and usually the only one.

Reverse-chronological cards. Each shows transcript preview, duration, time, and a **destination badge** (`Notes` · `Reminders` · `Claude` · `Unrouted`). Pull to sync. That's it.

The badge is the important bit — it tells you at a glance that the thing already went where it should, so you can close the app.

**2. Note detail** — transcript, audio scrubber, edit, re-route, delete. Raw and cleaned text both available; people distrust cleanup they can't inspect.

**3. Routing rules** — the differentiator, and the only screen worth real design effort.

| Phrase | Destination |
| --- | --- |
| "note to self…" | Apple Notes |
| "remind me to…" | Reminders (parse the time) |
| "hey Claude…" | clipboard / Claude, waiting on the laptop |
| "add to \<list\>…" | that list |
| *(no phrase)* | Inbox, unrouted |

User-editable. Ships with sensible defaults. Fork Cadence's parser.

**4. Device** — battery %, notes pending, storage, last sync, firmware. Boring on purpose. Also where tap sensitivity gets calibrated.

**5. Onboarding** — pair, tap-calibrate (tap it three times so the threshold fits how *you* tap and what you wear it over), choose destinations, record one test note end-to-end. Under two minutes.

### The states that actually matter

Most of the app's difficulty is not screens, it's these:

| State | Behaviour |
| --- | --- |
| Phone out of range | Device holds it. Nothing is lost. Badge shows pending count on next connect |
| Sync interrupted | Chunked and resumable. **Verify-then-erase** — never delete from device until the phone confirms the write |
| Transcription uncertain | Flag it. Show confidence; don't silently ship garbage |
| Recorded while moving | IMU flags the segment: "this one was noisy" |
| No routing phrase heard | Land in Inbox unrouted rather than guessing wrong |
| Device full | Warn at 80 %, refuse new recordings at 100 % rather than overwrite |

**The rule: it is always better to surface an uncertain note than to silently lose or misfile one.** Trust in a capture device is destroyed exactly once.

### Why this is the easy half

Cadence already does push-to-talk capture, on-device Apple Speech transcription, rule-based cleanup, routing-phrase parsing, and delivery to a named destination. **The phone pipeline is written and shipped.** What's new is the BLE transport layer and the inbox UI — genuinely the smaller job, which is why the hardware risk in §5 deserves the attention.

---

## 7. Build order

| Phase | What | Gate |
| --- | --- | --- |
| **0** | **Split-bar antenna rig.** Steel tube, ceramic band, nRF dev board, measure range on-body. **~$150.** | Does BLE get out? If no, the product is plastic — find out now |
| **1** | XIAO + LIS2DW12 taped to a steel bar on a chain. Tap detection + chain-noise recording. | Does tap-vs-double-tap work? Is chain noise survivable? |
| **2** | Mic port + compliant mount test on printed shells. Record walking, sitting, talking. | Is transcription usable at chest distance? |
| **3** | Cadence integration — BLE sync, on-device transcription, routing. Software half already exists. | End-to-end note in under 10 s |
| **4** | Custom 3.5 mm rigid-flex, 5 boards. | |
| **5** | 6 mm steel tube bodies, 20 units, real people. | |

**Phases 0–2 are the whole risk and cost under $400.** Antenna, tap, mic. Everything after is execution.

**Wear the ugly version for a month before spending real money.** If you don't reach for it, industrial design won't save it.

---

## 7a. What to order now

**Phase 0 cart — ~$180.** Everything needed to answer the antenna question and feel the size.

| Item | Why | ~$ |
| --- | --- | --- |
| **The actual Slim Bar Pendant (40 × 4 mm)** | hold the target. Decide 5 vs 6 mm physically | 40 |
| **316 stainless square tube**, 5×5 and 6×6, 0.3–0.5 mm wall, 300 mm | the body. Buy both, cut, compare on your chest | 25 |
| **Seeed XIAO nRF52840 Sense** | mic + IMU + charging on board. Phase 0/1 brain | 20 |
| **Zirconia or PTFE rod**, 5–6 mm dia | the insulating antenna band | 15 |
| 150 mAh LiPo (bench, not final) | power the rig | 8 |
| Chain + bail assortment | **ask the Vancouver wholesaler** — see below | ~0 |
| Copper tape, thin coax/RG-178 pigtail, SMA | feed the split-bar dipole | 25 |
| Silicone sheet 0.5 mm, acoustic mesh | compliant mic boot | 10 |
| Digital calipers (if you don't have them) | non-negotiable for this project | 25 |

**Nice to have:** a **nRF52840 dongle** (~$10) as a BLE sniffer/RSSI meter — it turns "does the antenna work" from a guess into a measurement.

### The jewellery connection is a real asset — use it early

A wholesale jewellery supplier in Vancouver gets you, in rough order of value:

1. **Chains and bails at cost**, in the exact gauges that look right — the photo's chain is ~4 mm rolo, and chain choice changes the whole read of the object.
2. **A finisher.** Someone who already brushes, polishes, and PVD-coats steel. This is the difference between "machined part" and "jewellery," and it is not something you can do at home.
3. **Manufacturing vocabulary and contacts** — casting, plating, tumbling, laser engraving. The pendant is described as engravable; that's a personalisation SKU for free.
4. **A retail channel and a reality check.** Show them the bar. If a jeweller says it reads as a gadget, that's the cheapest negative feedback you will ever get.

**Ask specifically for:** hollow/tube stock sources, whether they can polish a 6 mm tube end-to-end, and what a 4 mm vs 6 mm bar does to perceived price.

### CAD — yes, but not first

You'll need a model, but not before Phase 0. Sequence:

1. **Stack-up sketch first** (paper or a 2D sketch). Blocks on a line: end cap · mic · PCB · battery · antenna band · end cap. Sum the lengths. If they don't add up to 60 mm, no amount of CAD helps.
2. **Fusion 360** (free personal/startup licence) for the body. Model the tube, both end caps, the bail lug, mic port, and the contact pads.
3. **Import the board as a STEP** once there's a PCB — Fusion and KiCad round-trip this, and it's the only reliable way to catch a component colliding with a wall.
4. **Print the shell in resin at 1:1** before cutting any steel. A $2 print catches proportion mistakes that a $200 tube can't un-cut.

**Model the internal stack-up before the external shape.** The outside is 30 minutes of work; the inside is where it fails.

---

## 8. Money

| | |
| --- | --- |
| Phases 0–2 (the real questions) | **~$400** |
| Custom boards | ~$600 |
| 20 units | ~$2,500 |
| Steel tube @ volume | pennies + $8–20/unit finishing |
| NMT / ceramic band tooling | the real cliff — quote it at phase 4 |

Metal costs more than plastic and is non-negotiable. It's the product.

---

## 9. Decisions needed

1. **Steel or titanium for v1?** Steel is cheaper and buyable as tube; titanium is lighter, more hypoallergenic, and 1–3 dB better for RF.
2. **Leather cord as launch SKU or v2?** Acoustically it's the better answer, and it may be the better-looking one.
3. **Brushed or polished first?** Polished shows every scratch on something that swings into door frames.
4. **Does it need to be 5 mm?** 6 mm ships this year. 5 mm needs a 50k-unit battery order.

---

## 10. Next action

Order 5 × 5 mm and 6 × 6 mm stainless square tube (0.3–0.5 mm wall), a ceramic spacer, and build the phase-0 antenna rig against a dev board.

**Everything else in this plan is downstream of one question: can BLE get out of a steel bar.**
