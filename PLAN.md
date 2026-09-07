# Pocket note-taker — plan

**One line:** a thing in your pocket. Squeeze it, talk, let go. The note is on your phone before you've put it away.

---

## 1. The strategic point, first

The AI-wearable market right now is **always-on life recorders**, and that category has a problem it can't design its way out of: it records everyone around you, all the time. That forces a subscription (constant cloud transcription is expensive), it forces big batteries, and it makes people uncomfortable in a way that shows up in every review.

**Deliberate capture is a different product.** Push-to-talk means:

| | Always-on pendant | This |
| --- | --- | --- |
| Privacy | records everyone, always | records only when you press it |
| Battery | must last all day recording | idle 99.9% of the time — weeks |
| Transcription cost | hours per day | seconds per day |
| Subscription | structurally required | optional |
| Storage | gigabytes | megabytes |
| Social friction | high | none — it's a voice memo button |

That is the whole thesis. It isn't a smaller version of a Limitless Pendant; it's the thing people actually reach for, which is the voice memo app, minus unlocking your phone.

### The market as of now

| Product | Price | Model | Status |
| --- | --- | --- | --- |
| **Plaud Note** | ~$159–179 | card-shaped, deliberate capture, subscription tiers | the one to beat |
| **Bee** | $49.99 + $19/mo | always-on pendant | $278 in year one |
| **Omi** | $89 | always-on pendant | open-ish ecosystem |
| **Limitless Pendant** | — | always-on pendant | **acquired by Meta Dec 2025, no longer sold** |

Limitless being absorbed and shut down is the opening. It removed the best-designed competitor from the market and stranded its users.

**Plaud is the real competitor** and it's already deliberate-capture. Differentiation has to be sharper than "same but cheaper":
- **No subscription for the base loop.** Transcription on-device on the phone (Apple Speech / Android SpeechRecognizer) is free and offline. Charge only for the cloud/LLM tier.
- **One-hand, eyes-free, in-pocket.** Plaud is a card you take out and look at. This is a squeeze you never look at.
- **It goes somewhere.** See §6 — this is the part nobody else has.

---

## 2. What it does

```
squeeze ─▶ haptic tick ─▶ you talk ─▶ release ─▶ haptic tick
                                                     │
                                          stored + compressed on device
                                                     │
                                    BLE sync when phone is in range
                                                     │
                              transcribed on phone, on-device, free
                                                     │
                                       lands where you told it to go
```

No screen. No app to open. The interaction is one button and two haptic ticks, so it works in a pocket, in a bag, walking, mid-conversation.

**Store-and-forward, not streaming.** The device records to its own flash and syncs later. This matters: it works when your phone is in another room, in a bag, or dead. A streaming device is useless the moment it's out of range, and it burns radio power constantly.

---

## 3. Hardware

### Prototype — build this first, it's a weekend

| Part | Why | Cost |
| --- | --- | --- |
| **Seeed XIAO nRF52840 Sense** | nRF52840 + **PDM mic already on board** + IMU + LiPo charging, 21×17.5mm | ~$20 |
| LiPo 3.7V 400 mAh | ~2 weeks idle, plenty of recording | ~$8 |
| Momentary tactile switch | start here, not capacitive — see below | ~$1 |
| Coin vibration motor | the haptic tick | ~$2 |
| 3D-printed shell | — | ~$5 |
| Wire, JST connector | — | ~$5 |
| **Total** | | **~$40** |

The XIAO Sense is the reason to start here rather than designing a board: the microphone and the battery charger are already on it, so the prototype is a battery, a button and a motor soldered to a $20 board. You can have a working device before committing to any layout.

**Why nRF52840 over ESP32-S3:** 5 µA deep sleep vs ~14 µA, and far more importantly the ESP32 pulls 80–100 mA with the radio active against the nRF's near-negligible BLE overhead. For a device that idles 99.9% of the time and wakes for 20 seconds, that difference is weeks of battery versus days. ESP32-S3 only wins if you need Wi-Fi, and you don't — the phone is the uplink.

**Button, not capacitive touch, for v1.** Capacitive feels premium and fails in a pocket: fabric, moisture and body capacitance all trigger it. A real switch with a defined click is eyes-free, gives tactile confirmation, and cannot false-fire against your leg. Revisit for v2 with a force sensor if the click feels cheap.

### Production BOM (per unit)

| Part | @100 | @1,000 |
| --- | --- | --- |
| nRF52840 module (Raytac/Fanstel) | $6.00 | $4.50 |
| MEMS mic (ICS-43434 / SPH0645, I²S) | $1.50 | $1.10 |
| 32 MB SPI flash (W25Q256) | $1.50 | $1.00 |
| Charge IC + protection (BQ25101 + DW01) | $1.00 | $0.70 |
| LiPo 400 mAh | $3.00 | $2.00 |
| USB-C receptacle | $0.30 | $0.18 |
| LRA haptic + driver (DRV2605L) | $1.60 | $1.10 |
| Switch, LED, passives | $1.50 | $0.90 |
| PCB, 4-layer, ~25×45mm | $2.00 | $0.80 |
| Enclosure | $10.00 (CNC/SLA) | $2.50 (injection) |
| Assembly + test | $5.00 | $2.50 |
| **BOM total** | **~$33** | **~$17** |

**Injection mould tooling: $3,000–8,000.** That's the cliff. Below ~500 units, 3D-print or CNC the shells and eat the $10.

At $17 landed you can sell at $79–99 with healthy margin and undercut Plaud by half.

---

## 3a. Form factor — the device as a link, not a pendant

**Reference: a men's chain, where the device closes the loop.** It isn't a pendant hanging off the chain; it *is* a section of the chain. A barrel or clasp that happens to be electronics. Every competitor is a pendant or a card. Nothing on the market is jewellery.

**Target envelope: roughly 42 × 13 × 9 mm.** Read as a chunky clasp or a barrel bead. For comparison the Bee pendant is ~30 × 30 × 10 mm and reads unmistakably as a gadget.

### Does it fit? Yes, and only because of push-to-talk.

| Part | Footprint |
| --- | --- |
| Raytac MDBT50Q (nRF52840 module) | 10.5 × 15.5 × 2.2 mm |
| ICS-43434 MEMS mic | 3.5 × 2.65 × 1.0 mm |
| W25Q256 flash (WSON-8) | 6 × 5 × 0.8 mm |
| Charge IC + protection | ~3 × 3 mm each |
| LRA haptic | 10 × 3 mm |
| **Battery — the real constraint** | see below |

A 42 × 13 × 9 mm barrel leaves roughly **4 × 11 × 20 mm** for a cell after walls and board. That's a **401120 pouch, ~90 mAh**.

90 mAh sounds fatal. It isn't:

| | |
| --- | --- |
| Idle at 10 µA | **375 days** |
| Real use, 20 notes/day at 30 s | **~38 days** |
| Charge time | under an hour |

**This is the payoff of the deliberate-capture thesis.** An always-on recorder at ~8 mA continuous would drain this cell in **11 hours** — which is exactly why every always-on competitor is a fat pendant. Push-to-talk is what makes jewellery-scale possible. The form factor and the product thesis are the same decision.

### The microphone problem — the hardest part of the build

You identified this yourself and you're right that it's the thing that kills it. A mic rigidly mounted inside a metal shell attached to a metal chain is a **contact microphone for the chain**. Every link tick conducts straight into the diaphragm as structure-borne noise, and it will be louder than your voice.

Four things fix it, in order of importance:

1. **Never hard-mount the mic to the shell.** Suspend it on a compliant silicone boot or gasket so the mechanical path from shell to mic is broken. This is the single highest-leverage mechanical decision in the whole device.
2. **Port upward, toward the mouth**, not outward. A chain sits at the sternum; the mouth is ~25 cm up and behind. An upward port with a short, sealed acoustic channel beats a bigger mic in the wrong place, every time.
3. **Push-to-talk does most of the work for free.** The mic is only live while you're deliberately holding the button, and people naturally still themselves to speak. An always-on device has to survive a jog; this one only has to survive standing still for 20 seconds.
4. **Use the IMU you already have.** The XIAO Sense has a 6-axis IMU. Flag segments recorded during high motion so the app can warn "this one was noisy" instead of silently producing garbage transcript.

Acoustic mesh over the port for wind and lint. Test the port geometry on a printed shell **before** committing to a board layout — this is the thing most likely to force a redesign.

### Interaction

**Squeeze, not press.** Button on the back, thumb braced on the front. On a chain-mounted barrel that's the only gesture that works one-handed without lifting the device to look at it, and it doesn't yank the chain against your neck.

- **Press and hold** = record while held. Unambiguous, no state to forget, matches Cadence exactly.
- **Double-click** = hands-free mode, records until clicked again, for longer thoughts.
- Two haptic ticks: one on start, one on stop. **No LED as the primary feedback** — you can't see your own chest.

### Charging: magnetic pogo pins, not USB-C

A USB-C receptacle is ~8.9 mm wide and needs a hole in the shell. On a 13 mm-wide piece of jewellery that's most of the width and a water ingress path.

**Two pogo pads on the back and a magnetic cable.** It lets the shell be effectively seamless, survives sweat, and is what every piece of wearable jewellery does. It also costs less board area.

### Drop Wi-Fi

You mentioned Wi-Fi as an option. Don't. The nRF52840 has no Wi-Fi radio, adding one means a second chip, and Wi-Fi's power draw is incompatible with a 90 mAh cell. **BLE only.** The phone is the uplink; it already has Wi-Fi.

### Mechanical: the load path

The chain pulls on this thing all day. **The anchor points must tie into the shell, not the PCB.** Two machined lugs at each end, with the board floating inside on a compliant mount so no chain load ever reaches a solder joint. This is how a watch case works and it's the difference between a product and something that fails in a month.

Shell: **CNC stainless or brushed aluminium** at low volume. It's jewellery, it will be judged as jewellery, and a printed plastic shell reads as a prototype no matter how good the electronics are.

### What this changes about cost

CNC metal shells at low volume run **$15–25/unit** rather than the $10 printed estimate in §3, and the smaller cell saves about a dollar. Call it **~$40/unit at 100**, versus $33 for the plastic pocket version. At 1,000 with tooling it converges back toward $20.

The metal shell is worth it. It's the difference between a gadget and something someone wears.

---

## 4. Firmware

**nRF Connect SDK (Zephyr).** Nordic's own stack, best-documented path for this chip.

```
button ISR ─▶ wake from System OFF
           ─▶ haptic tick
           ─▶ PDM/I²S mic on, 16 kHz mono
           ─▶ encode ─▶ ring buffer ─▶ SPI flash
release    ─▶ haptic tick, close the record, sleep
BLE        ─▶ on connect: advertise pending notes, transfer, verify, erase
```

**Codec — the one real engineering decision.**

| Option | Bitrate | 60s note | CPU | Verdict |
| --- | --- | --- | --- | --- |
| Raw PCM 16k/16-bit | 256 kbps | 1.9 MB | none | too big |
| **IMA ADPCM 4:1** | 64 kbps | 480 KB | trivial | **start here** |
| Opus 16 kHz | 24 kbps | 180 KB | heavy on M4F | v2 target |

Start with ADPCM. It's ~20 lines, costs nothing, and 32 MB of flash still holds **~65 one-minute notes**. Opus is 2.6× better but it's a real port and it eats the CPU budget on a 64 MHz M4F. Don't fight that battle before the product exists.

**Power budget** (400 mAh):
- Deep sleep: ~10 µA → months
- Recording: ~8 mA → ~50 hours of actual talking
- BLE sync: ~7 mA in bursts

Realistically **3–6 weeks per charge** at 20 notes/day. That is the number to advertise, and it's a category-beating one precisely because the thing isn't always on.

---

## 5. The phone app

**React Native or Flutter**, one codebase.

1. **BLE sync** — background transfer, chunked, resumable, verify-then-erase. Never delete from the device until the phone confirms the write.
2. **Transcription — on-device by default.** `SFSpeechRecognizer` with `requiresOnDeviceRecognition = true` on iOS; `SpeechRecognizer` on Android. **Free, offline, private.** This is the whole reason there's no mandatory subscription.
3. **Cleanup** — fillers out, punctuation and capitals in, deterministic rules first.
4. **Routing** — where the note goes.

**The base product must work fully offline with no account.** Cloud LLM summarising, search across notes, and multi-device sync are the paid tier. If the free tier is genuinely useful, the paid one sells itself; if the free tier is crippled you're Bee, charging $19/month.

---

## 6. Why you specifically should build this

**You already built the software half.** Cadence is a push-to-talk capture app that transcribes on-device with Apple Speech, cleans the text with rule-based passes, parses a routing phrase out of the speech, and delivers it to the right destination. That is *exactly* this product's phone-side pipeline, already written, already shipped, already notarised.

The device is the missing front-end for something you've already built.

And it gives the product the thing no competitor has: **notes that route themselves.** Squeeze it and say *"note to self, buy the L298N"* and it lands in your notes. Say *"hey Claude, why did the servo jitter"* and it's a prompt waiting on your laptop. Plaud gives you a transcript in Plaud's app. This puts the thought where the thought belongs.

That's the pitch, and it comes from work you've already done.

---

## 7. Build order

| Phase | What | Time | Cost |
| --- | --- | --- | --- |
| **0** | XIAO + button + battery on a breadboard. Record on press, dump WAV over USB. Proves mic, storage, power. | a weekend | $40 |
| **1** | Add BLE transfer. A crude phone app that receives a file and plays it. **The riskiest part — do it early.** | 1–2 weeks | $0 |
| **2** | Transcription on the phone. Fork Cadence's cleanup and routing logic. | 1–2 weeks | $0 |
| **3** | 3D-printed shell, LiPo, haptics. A thing you carry for a month. **Carry it. The month is the point.** | 2 weeks | $60 |
| **4** | Custom PCB, 5 boards from JLCPCB. | 3–4 weeks | ~$300 |
| **5** | 20 units to real people. | 6 weeks | ~$1,000 |

**Phase 3 is the decision gate.** Carry it every day for a month. If you don't reach for it, no amount of industrial design saves it — and you'll have spent $100 instead of $10,000 finding that out.

---

## 8. What will actually go wrong

1. **BLE throughput.** Practical is ~100–300 kbps, well under the theoretical 2 Mbps. A 480 KB note takes ~20–40 seconds. Fine for notes, fatal for hours of audio — another reason the deliberate-capture model is the right one.
2. **Microphone placement.** The single biggest determinant of transcription quality, and it's mechanical, not software. A mic port sealed by fabric or a badly-designed acoustic path ruins everything downstream. Prototype the port before the enclosure.
3. **iOS background BLE.** Restrictive. Needs the right background modes and state restoration, and Apple will ask why during review.
4. **Recording law.** You're building a recording device. Canada is one-party consent, so recording yourself is unambiguous. Several US states (California, Washington, Illinois, Florida) are **all-party consent** — recording a conversation without everyone's agreement is a crime there. Deliberate capture of your own voice is the safe case and another reason not to build an always-on recorder. Get this right in the marketing copy before you ship, not after.
5. **Battery certification.** Shipping lithium cells across borders means UN38.3 testing and specific packaging. Budget for it before you sell internationally.
6. **You'll want to add a screen.** Don't. The absence of a screen is the product.

---

## 9. Money

| | |
| --- | --- |
| Get to a carryable prototype | **~$150** |
| Get to 5 custom boards | **~$450** |
| Get to 20 sellable units | **~$1,500** |
| Injection tooling (only past ~500 units) | **$3,000–8,000** |

You can reach a real, wearable, working device that syncs to your phone for **under $200** — and that's the only milestone that matters, because it's the one that tells you whether the idea is right.

---

## 10. Next action

Order a **Seeed XIAO nRF52840 Sense**, a **400 mAh LiPo**, and a **tactile switch**. About $30. Phase 0 needs nothing else, and the on-board microphone means you can test the single most uncertain thing — whether audio quality from a pocket is good enough to transcribe — before designing anything at all.
