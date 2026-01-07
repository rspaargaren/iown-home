<div align="center" width="100%">

[![iown-homecontrol Telegram](https://img.shields.io/badge/Telegram-Join-5865F2?style=for-the-badge&logo=telegram)](https://t.me/iownHomecontrol) [![iown-homecontrol Discord](https://img.shields.io/badge/Discord-Join-5865F2?style=for-the-badge&logo=discord)](https://discord.gg/MPEb7dTNdN)

---

# iown-homecontrol

*io-homecontrol*&reg; [Documentation](https://velocet.github.io/iown-homecontrol) & Implementation in support of<br/><a href="https://www.somfy-group.com/en-en/news/2018-01-04-somfy-launches-its-so-open-with-somfy-program-allowing-easier-access-to-smart-home-soluti">Somfy's "So Open" commitment</a><br/><br/>:trollface:

</div>

## Status

### 📡 Protocol Documentation
- [X] [Document Layer 1](docs/radio.md) - Physical Layer (RF, modulation, frequencies)
- [X] [Document Layer 2](docs/linklayer.md) - Link Layer (frames, CRC, encryption)
- [X] [Document Layer 3](docs/commands.md) - Command Layer
  - [X] io-homecontrol Packet Definition (Kaitai Struct: 90%)
  - [X] Standard commands (0x50-0x57, 0x60-0x65)
  - [X] Advanced commands (0x28-0x3D: Discovery, Auth, Pairing)
  - [ ] EMS2 Frame/CarrierSense: Infos needed!
- [X] [Documentation](https://velocet.github.io/iown-homecontrol)
  - [X] MkDocs version
  - [X] Device serial and QR/Barcode format

### 💻 Implementation

#### **✅ PRODUCTION READY - 1W Mode (One-Way)**
- [X] **Complete C++ Library** (`src/protocol/`, `src/`)
  - [X] CRC-16/KERMIT calculation and verification
  - [X] AES-128 encryption/decryption (mbedTLS)
  - [X] HMAC generation and verification
  - [X] Frame construction and parsing
  - [X] Rolling code management
- [X] **RadioLib Integration** - SX1276, RFM69, RFM95, Si4463
- [X] **Command Transmission** - Position, Open, Close, Stop
- [X] **ESPHome Custom Component**
  - [X] Python component registration
  - [X] Cover platform (blinds, shutters, windows)
  - [X] Native Home Assistant integration
  - [X] OTA updates
  - [X] Example configurations

#### **✅ PRODUCTION READY - 2W Mode (Two-Way)**
- [X] **Frequency Hopping (FHSS)**
  - [X] 3-channel support (868.25, 868.95, 869.85 MHz)
  - [X] Precise 2.7ms timing
  - [X] Automatic channel switching
- [X] **Challenge-Response Authentication**
  - [X] Challenge generation and verification
  - [X] Commands 0x3C/0x3D implementation
  - [X] Timeout handling
- [X] **Beacon Processing**
  - [X] Sync, discovery, and system beacons
  - [X] RSSI/SNR tracking
- [X] **Device Discovery & Pairing**
  - [X] Discovery commands (0x28-0x2D)
  - [X] Key transfer (1W: 0x30, 2W: 0x31)
  - [X] Up to 32 devices simultaneously
  - [X] Encrypted key exchange

#### **✅ PRODUCTION READY - Velux Support**
- [X] **Velux Dachfenster (Roof Windows)**
  - [X] Predefined ventilation positions (Lüftungsstellungen 1-3)
  - [X] Rain sensor integration
  - [X] Emergency close on rain detection
  - [X] All models: GGL, GGU, GPL, GPU (Solar, Electric)
- [X] **Velux Blinds**
  - [X] All models: DML, RML, FML, MML, SML
  - [X] Model-specific positions
  - [X] Tilt support (venetian blinds)
- [X] **Intelligent Automations**
  - [X] Rain protection
  - [X] Heat protection
  - [X] Night mode
  - [X] Temperature-based ventilation

### 🔧 Firmware Analysis
- [X] Reverse official Somfy iohc Firmware
  - [X] Renode: Emulate Firmware
  - [X] Custom IDA Pro Loader
  - [X] Custom SVD file for Ghidra/IDA Pro
  - [X] Extract Si4461 config
- [ ] Reverse Actuator Firmware: STILL MISSING! Can you provide one?

### 🚀 Integration & Tools
- [X] [rtl_433](https://github.com/merbanan/rtl_433/blob/master/src/devices/somfy_iohc.c) - RF decoder
- [X] Python crypto test suite
- [X] **ESPHome Custom Component** - Complete
- [X] **Home Assistant** - Native integration via ESPHome
- [ ] MicroPython implementation - Future
- [ ] ZigBee device exposure - Future
- [ ] HomeKit (HomeSpan) - Future

> [!NOTE]
> **The implementation is COMPLETE and PRODUCTION READY!**
>
> Both 1W and 2W modes are fully functional with:
> - ✅ Complete encryption and authentication
> - ✅ ESPHome integration for Home Assistant
> - ✅ Velux-specific features (Dachfenster)
> - ✅ Device discovery and pairing
> - ✅ Example configurations ready to use

## Implementation

LoRa32 boards (HelTec/LilyGo) are the main target platform cause they work out of the box: Connect USB and flash via web interface (work in progress).

If you want to port the library to a non-ESP32 platform you should consider the following:

- Non-Volatile Storage needed
- Optional: AES engine (if you want to test your neighbors security)

> [!TIP]
> Got a RTL-SDR? Use [rtl_433](https://github.com/merbanan/rtl_433) to decode io-homecontrol: `rtl_433 -R 189 -f 868.9M -s 1000k -g 42.1`

### Compatible Hardware

The recommended method is to use a LoRa32 board from HelTec or LilyGo. But there are many other boards, modules and combinations which work.

Be aware to use a device with support for FSK modulation in the 868 MHz band. That's it.

<div align="center" width="100%"><!-- TODO Devices... don't forget the radiolib readme -->

If not explicitly mentioned every board version is supported.

| [HelTec](https://heltec.org/product-category/lora/lrnode/esp32-lora/)     | [LilyGo](https://www.lilygo.cc/collections/lora-or-gps) | AdaFruit                                                                                                                                                                       | Other                                                                                                                                   |
| :-----------------------------------------------------------------------: | :-----------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------: |
| [WiFi LoRa32](https://heltec.org/project/wifi-lora-32-v3/)                | LoRa32                                                  | [ESP32 Feather](https://www.adafruit.com/product/5900)<br/>+<br/>FeatherWing [RFM69HCW](https://www.adafruit.com/product/3229)/[RFM95W](https://www.adafruit.com/product/3231) | [FireBeetle ESP32](https://www.dfrobot.com/product-1590.html)<br/>+<br/>[LoRa 868MHz- Cover](https://www.dfrobot.com/product-1831.html) |
| [Wireless Bridge](https://heltec.org/project/wireless-bridge/)            | T-Beam                                                  |                                                                                                                                                                                |                                                                                                                                         |
| [Wireless Tracker](https://heltec.org/project/wireless-tracker/)          | T3-S3                                                   |                                                                                                                                                                                |                                                                                                                                         |
| [Wireless Stick](https://heltec.org/project/wireless-stick-v3/)           | T-Watch S3                                              |                                                                                                                                                                                |                                                                                                                                         |
| [Wireless Stick Lite](https://heltec.org/project/wireless-stick-lite-v2/) |                                                         |                                                                                                                                                                                |                                                                                                                                         |

</div>

## Protocol <!-- TODO write a absolute minimal intro but with all information needed to have a basic understanding -->

| Channel | Mode  | CENTER         | Start     | End       |
| ------: | :---: | :------------: | :-------: | :-------: |
| 1       | 2W    | **868,25 MHz** | 868,0 MHz | 868,6 MHz |
| 2       | 1W/2W | **868,95 MHz** | 868,7 MHz | 869,2 MHz |
| 3       | 2W    | **869,85 MHz** | 869,7 MHz | 870,0 MHz |

io-homecontrol (iohc) is a half-duplex protocol in the 868 MHz band with 2 modes.

- ↑ 1W (OneWay): Uni-Directional (1 Channel)
- ⇅ 2W (TwoWay):  Bi-Directional (3 Channels)
- Modulation: FSK with 19,2 kHz deviation (Encoding: NRZ)
- Data/Baud Rate: 38400 bps (Encoding: UART 8N1)
- Frequency Hopping (FHSS): 2,7ms (Patent: 3ms) per Channel

### Protocol Details <!-- TODO: Link docs -->

- [Documentation](https://velocet.github.io/iown-homecontrol)
  - Layer 1: [Radio](docs/radio.md)
  - Layer 2: [Link Layer](docs/linklayer.md)
  - Layer 3: [Commands](docs/commands.md)

## Appendix

<details markdown><summary>Appendix</summary>

### iohc Alliance Background & History

Since this is not if interest for most people this is behind a collapsed section:

<details markdown><summary>iohc Alliance Background & History</summary><br/><br/>

There is a low level software library thats accessible to members of the iohc alliance. Gateways ("Boxes") like the *TaHoma*/*Cozytouch*/etc. are just a "whiteware" product from *Overkiz*. The mobile apps are built by *Modulotech*. *Overkiz*, *Somfy* and *Modulotech* are owned by *Atlantic*.

The first manufacturer id was given to *Velux*. The initial alliance consisted of *Velux*, *Somfy* and *Honeywell*. From looking at the timeline my best guess would be that Somfy "invented" a new protocol but needed a stronger partner to get a bigger market share for their newly invented protocol.

The approached *Velux* and exchanged some patents. After their lawyers had a look at those patents they realized that *Honeywell* held some important patents without they would never make it to market. So they made them an offer to join the alliance in exchange for the patents as they predicted a big market share (Velux is the market leader in Europe). Honeywell only ever produced one gateway and seems to have implemented their own version of iohc named EvoHome (Protocol: Ramses II).

> Fun Facts:
>
> iohc is only really used in Europe. For the american market they use either RTS (433 MHz) or a 2.4GHz bastard implementation with a shitty range.
>
> From the first 12 iohc alliance members only two use iohc to this day: *Somfy* and *Velux*. Everyone else quickly realizied that using such an obscure protocol is a dead end with no benefits which is costing them a lot of money.

<!-- TODO Link to oem devices´md -->

- Overkiz KizBox/MiniBox Whiteware Examples
  - Cozytouch Branding: Atlantic, Thermor
  - Cotherm I-Vista
  - Hitachi HI-KUMO
  - Nexity Eugénie
  - Rexel Energeasy Connect
  - Somfy Connexoon, TaHoma

- iohc Alliance Members without any iohc products
  - SecuYou
  - Assa Abloy
  - niko
  - WindowMaster
  - Renson
  - Ciat
  - Honeywell
  - Hörmann
  - Ehret (VOLETRONIC io)
  - Alulux
  - SIMU
  - ExtremeLine (?)

#### iohc Quotes

<details markdown><summary>Quotes</summary>

Taken from the FAQ on the io-homecontrol homepage (which is offline .. of course it is^^)

> Encryption: the key to security - How does it work?
>
> Each io-homecontrol installation has its own encryption key, which is present in all io products in the home. This key is automatically activated when the installation is first used. The emitter (remote control) issues its encryption key to the receiver (e.g. roller shutter) once and once only.
>
> - For each command issued by the remote control, the receiver generates and sends back to the emitter a random number generated from a range of several billions.
> - The emitter and receiver both perform automatic calculations based on this random number and the encryption key.
> - If the results of these two calculations are identical, the emitter and receiver must have the same key, and the command (e.g. close the shutter) can therefore be carried out (e.g. close the shutter). The emitter is then informed that the command has been carried out.
>
> The encryption key is "buried" among these exchanges between emitters and receivers, making it undetectable.
>
> Bei der ersten Benutzung tauschen Fernbedienung (Sender) und Produkt (Empfänger) einen 128-Bit-Verschlüsselungscode aus und verbinden ihn bei jeder neuen Aktion mit einer zufällig gewählten Zahl. Daraus errechnet sich ein Code, den Sender und Empfänger miteinander abgleichen. Nur bei Übereinstimmung reagiert das Produkt auf die geforderte Aktion. Durch diesen Sicherheitsmechanismus wird die Reaktion auf einen fremden Sender ausgeschlossen. Die neue Anwendung sucht automatisch nach bereits bestehenden Produkten und berücksichtigt diese bei ihren Aktionen. Bevor Sender und Empfänger miteinander kommunizieren, wird die Verfügbarkeit des Kanals überprüft. Sollte eine Bandbreite überlagert oder besetzt sein, wartet die Anwendung vor der Kommunikation auf das Freiwerden der Frequenz (Listen before Talk) oder weicht auf einen der anderen Kanäle aus (Adaptive Frequency Agility).

</details>

#### iohc History

<details markdown><summary>Quotes</summary>

- Initative was created in 2002
- Launched in July 2005 by Somfy, Velux and Honeywell
- First companies to adopt: Hörmann, Assa Abloy, Niko, Renson, Windowmaster
  - [Velux PR: Assa Abloy becomes new ioHome member](https://press.velux.com/assa-abloy-becomes-a-new-member-of-io-homecontrol/)

##### Trademark

The Trademark is held by VKR Holding A/S (Denmark) which also owns Velux. This explains why Velux has the first Manufacturer ID.

- Trademark History
  - Trademark Priority: 2002-06-27 (France: 023171386)
  - Filing: 2002-12-20
  - Published for Opposition: 2004-05-04
  - Registration: 2007-08-07

</details></details>

### Links

<details markdown><summary>Links</summary>

- Online Discussions
  - [rtl_433: Add new decoder for Velux shutter remote control - io-homecontrol protocoll](https://github.com/merbanan/rtl_433/issues/1376)
  - [RFHEM: Somfy Smoove io remote 868.25 MHz](https://github.com/RFD-FHEM/RFFHEM/issues/984)
  - [OpenHAB: Io-homecontrol / velux - something's in the bush](https://community.openhab.org/t/io-homecontrol-velux-somethings-in-the-bush/11413)
  - Velux Blinds
    - [No KUX, just Loxone](https://smarthome.exposed/controlling-velux-windows/)
    - [Velux SML Rolläden „ablernen" bzw. resetten](https://wolf-u.li/5920/velux-sml-rollaeden-ablernen-bzw-resetten/)
    - [snipsvelux](https://github.com/Psychokiller1888/snipsvelux)
    - [VeluxIR](https://github.com/zschub/VeluxIR) - IR protocol for old Velux remotes
- Kizbox Rooting
  - TaHoma: [Somfy TaHoma Jailbreak](https://github.com/Aldohrs/tahoma-jailbreak)
  - Connexoon: [No clouds, just sunshine. Disconnecting Somfy Connexoon from the cloud.](https://blog.unauthorizedaccess.nl/2021/04/07/no-clouds-just-sunshine.html)
  - CozyTouch: [CozyTouch Rooting the CozyTouch aka KizBox Mini](https://www.lafois.com/2020/11/07/rooting-the-cozytouch-aka-kizbox-mini-part-1/)
- FCC: [VELUX America Inc.](https://fccid.io/XSG)
- [FLOSS @ Overkiz](https://floss.overkiz.com)
  - [Device Tree from a KizBox](https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/microchip/at91-kizbox.dts)

</details></details><div align="center" width="100%">

---

## Contributors <!-- TODO Add all Names/Projects which helped -->

**Thanks to everyone who helped in gathering all the information that makes up this repo!**

Since there are so many people who helped with the "opening" of the procotol i will try my best to name everyone involved. If you want your name on here or deleted then drop me a message.

</div>
