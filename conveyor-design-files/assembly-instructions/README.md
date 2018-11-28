# Assembly Instructions
The conveyor belt is constructed mainly out of 3D printed parts, off the shelf hardware, and a purpose built PCB. This document is a detailed walk through on how to build your own.

## Tools, Supplies and Skills Required
* 3D Printer or access to 3D printing services
* Soldering equipment
* Metric hex wrenches
* 13mm box end wrench or adjustable end wrench
* Small flat and Phillips head screw drivers
* Fine grain sandpaper
* Loctite
* Heat set insert soldering tip (optional)
* 3MM drill bit (optional)

## Bill of Materials
We have provided a link to the bill of materials [bill of materials](BOM.md) needed to assemble the conveyor belt. This list includes:
* 3D STL files
* PCB files
* List of Electronic Components
* List of Mechanical Components

## Notes on 3D printing
The conveyor parts can be 3D printed using standard FDM printers. For the conveyor front and back pieces we have provided two versions. First is a two pice configuration that allows you to print these pieces on common printers that have a around a 200MM X 200MM build platforms. Second is a single piece configuration that requires at least a 300MM X 300MM build platform.

While we have printed conveyor belts in both PLA and PET we recommend using PET as it has better thermal and long term durability properties. This is especially important for the front piece where the stepper motor is mounted and can generate a bit of heat. We have tested several print settings and it looks like ~30% in fill works fine however for parts that receive heat set inserts we have been printed them with 4 parameters.

## Electronics

### PCB Layout
![PCB Layout](./images/pcb_layout.jpg)

We designed the layout of the PCB to allow you to extend the conveyor with additional sensors or actuators. We have broken out each pin of the ESP32 and provide a solderable breadboard area at the top right of the board. This breadboard area has a ground and 3.3V rails you can use to power your sensors.

### DRV8834 Stepper Motor Controller
Before we can use the DRV8834 we will need to set the current limit on the device for the particular stepper motor you are using for the conveyor. On the product page for the DRV8834 is a current limiting section that details how to perform this operation: [DRV8834 Product Page](https://www.pololu.com/product/2134). This process involves turning the trimmer potentiometer on the DRV8834 until a the voltage reference reaches the proper value. In the case of the Zyltech NEMA 17 Stepper Motor it runs at a maximum of 1.5 amps so the voltage reference on the DRV8834 should be set no more than 0.75V (we chose 0.7V and it seems to work fine). If you use a different motor you will need to make sure this value does not exceed the max amperage of the motor.   


### PCB Assembly
The PCB is populated with the following components:
* ESP32 micro-controller
* DRV8834 Stepper Motor Controller
* ADXL335 Accelerometer
* 100uF Capacitor
* Screw Terminals


While the ESP32, DRV8834, and ADXL335 can all be directly soldered to the board we suggest soldering 2.54MM female headers instead. Doing this allows you to replace the components incase of failure.

Depending on the version of the ESP32, DRV8834, and ADXL335 you purchase, you will need to first solder male 2.54MM headers on to each device before assembling it onto the conveyor.

Finished Top View:
![PCB Finished Top View](./images/pcb_top.jpg)

Finished Front View (note headers):
![PCB Finished Front View](./images/pcb_front.jpg)
