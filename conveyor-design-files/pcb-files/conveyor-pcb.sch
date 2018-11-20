<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<!-- Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved. -->
<!-- SPDX-License-Identifier: Apache-2.0 -->
<eagle version="8.2.2">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="50" name="dxf" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="53" name="tGND_GNDA" color="7" fill="9" visible="no" active="no"/>
<layer number="54" name="bGND_GNDA" color="1" fill="9" visible="no" active="no"/>
<layer number="56" name="wert" color="7" fill="1" visible="no" active="no"/>
<layer number="57" name="tCAD" color="7" fill="1" visible="no" active="no"/>
<layer number="59" name="tCarbon" color="7" fill="1" visible="no" active="no"/>
<layer number="60" name="bCarbon" color="7" fill="1" visible="no" active="no"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
<layer number="99" name="SpiceOrder" color="7" fill="1" visible="yes" active="yes"/>
<layer number="100" name="Muster" color="7" fill="1" visible="no" active="no"/>
<layer number="101" name="Patch_Top" color="12" fill="4" visible="no" active="yes"/>
<layer number="102" name="Vscore" color="7" fill="1" visible="no" active="yes"/>
<layer number="103" name="tMap" color="7" fill="1" visible="no" active="yes"/>
<layer number="104" name="Name" color="16" fill="1" visible="no" active="yes"/>
<layer number="105" name="tPlate" color="7" fill="1" visible="no" active="yes"/>
<layer number="106" name="bPlate" color="7" fill="1" visible="no" active="yes"/>
<layer number="107" name="Crop" color="7" fill="1" visible="no" active="yes"/>
<layer number="108" name="tplace-old" color="10" fill="1" visible="yes" active="yes"/>
<layer number="109" name="ref-old" color="11" fill="1" visible="yes" active="yes"/>
<layer number="110" name="fp0" color="7" fill="1" visible="yes" active="yes"/>
<layer number="111" name="LPC17xx" color="7" fill="1" visible="yes" active="yes"/>
<layer number="112" name="tSilk" color="7" fill="1" visible="yes" active="yes"/>
<layer number="113" name="IDFDebug" color="7" fill="1" visible="yes" active="yes"/>
<layer number="114" name="Badge_Outline" color="7" fill="1" visible="yes" active="yes"/>
<layer number="115" name="ReferenceISLANDS" color="7" fill="1" visible="yes" active="yes"/>
<layer number="116" name="Patch_BOT" color="9" fill="4" visible="no" active="yes"/>
<layer number="118" name="Rect_Pads" color="7" fill="1" visible="yes" active="yes"/>
<layer number="121" name="_tsilk" color="7" fill="1" visible="no" active="yes"/>
<layer number="122" name="_bsilk" color="7" fill="1" visible="no" active="yes"/>
<layer number="123" name="tTestmark" color="7" fill="1" visible="yes" active="yes"/>
<layer number="124" name="bTestmark" color="7" fill="1" visible="yes" active="yes"/>
<layer number="125" name="_tNames" color="7" fill="1" visible="no" active="yes"/>
<layer number="126" name="_bNames" color="7" fill="1" visible="yes" active="yes"/>
<layer number="127" name="_tValues" color="7" fill="1" visible="yes" active="yes"/>
<layer number="128" name="_bValues" color="7" fill="1" visible="yes" active="yes"/>
<layer number="129" name="Mask" color="7" fill="1" visible="yes" active="yes"/>
<layer number="131" name="tAdjust" color="7" fill="1" visible="yes" active="yes"/>
<layer number="132" name="bAdjust" color="7" fill="1" visible="yes" active="yes"/>
<layer number="144" name="Drill_legend" color="7" fill="1" visible="no" active="yes"/>
<layer number="150" name="Notes" color="7" fill="1" visible="yes" active="yes"/>
<layer number="151" name="HeatSink" color="7" fill="1" visible="no" active="yes"/>
<layer number="152" name="_bDocu" color="7" fill="1" visible="yes" active="yes"/>
<layer number="153" name="FabDoc1" color="7" fill="1" visible="yes" active="yes"/>
<layer number="154" name="FabDoc2" color="7" fill="1" visible="yes" active="yes"/>
<layer number="155" name="FabDoc3" color="7" fill="1" visible="yes" active="yes"/>
<layer number="199" name="Contour" color="7" fill="1" visible="yes" active="yes"/>
<layer number="200" name="200bmp" color="1" fill="10" visible="no" active="yes"/>
<layer number="201" name="201bmp" color="2" fill="10" visible="no" active="yes"/>
<layer number="202" name="202bmp" color="3" fill="10" visible="no" active="yes"/>
<layer number="203" name="203bmp" color="4" fill="10" visible="no" active="yes"/>
<layer number="204" name="204bmp" color="5" fill="10" visible="no" active="yes"/>
<layer number="205" name="205bmp" color="6" fill="10" visible="no" active="yes"/>
<layer number="206" name="206bmp" color="7" fill="10" visible="no" active="yes"/>
<layer number="207" name="207bmp" color="8" fill="10" visible="no" active="yes"/>
<layer number="208" name="208bmp" color="9" fill="10" visible="no" active="yes"/>
<layer number="209" name="209bmp" color="7" fill="1" visible="no" active="yes"/>
<layer number="210" name="210bmp" color="7" fill="1" visible="no" active="yes"/>
<layer number="211" name="211bmp" color="7" fill="1" visible="no" active="yes"/>
<layer number="212" name="212bmp" color="7" fill="1" visible="no" active="yes"/>
<layer number="213" name="213bmp" color="7" fill="1" visible="no" active="yes"/>
<layer number="214" name="214bmp" color="7" fill="1" visible="no" active="yes"/>
<layer number="215" name="215bmp" color="7" fill="1" visible="no" active="yes"/>
<layer number="216" name="216bmp" color="7" fill="1" visible="no" active="yes"/>
<layer number="217" name="217bmp" color="18" fill="1" visible="no" active="no"/>
<layer number="218" name="218bmp" color="19" fill="1" visible="no" active="no"/>
<layer number="219" name="219bmp" color="20" fill="1" visible="no" active="no"/>
<layer number="220" name="220bmp" color="21" fill="1" visible="no" active="no"/>
<layer number="221" name="221bmp" color="22" fill="1" visible="no" active="no"/>
<layer number="222" name="222bmp" color="23" fill="1" visible="no" active="no"/>
<layer number="223" name="223bmp" color="24" fill="1" visible="no" active="no"/>
<layer number="224" name="224bmp" color="25" fill="1" visible="no" active="no"/>
<layer number="225" name="225bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="226" name="226bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="227" name="227bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="228" name="228bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="229" name="229bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="230" name="230bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="231" name="231bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="248" name="Housing" color="7" fill="1" visible="yes" active="yes"/>
<layer number="249" name="Edge" color="7" fill="1" visible="yes" active="yes"/>
<layer number="250" name="Descript" color="3" fill="1" visible="no" active="no"/>
<layer number="251" name="SMDround" color="12" fill="11" visible="no" active="no"/>
<layer number="254" name="cooling" color="7" fill="1" visible="no" active="yes"/>
<layer number="255" name="routoute" color="7" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="SparkFun-Capacitors">
<description>&lt;h3&gt;SparkFun Capacitors&lt;/h3&gt;
This library contains capacitors.
&lt;br&gt;
&lt;br&gt;
We've spent an enormous amount of time creating and checking these footprints and parts, but it is &lt;b&gt; the end user's responsibility&lt;/b&gt; to ensure correctness and suitablity for a given componet or application.
&lt;br&gt;
&lt;br&gt;If you enjoy using this library, please buy one of our products at &lt;a href=" www.sparkfun.com"&gt;SparkFun.com&lt;/a&gt;.
&lt;br&gt;
&lt;br&gt;
&lt;b&gt;Licensing:&lt;/b&gt; Creative Commons ShareAlike 4.0 International - https://creativecommons.org/licenses/by-sa/4.0/
&lt;br&gt;
&lt;br&gt;
You are welcome to use this library for commercial purposes. For attribution, we ask that when you begin to sell your device using our footprint, you email us with a link to the product being sold. We want bragging rights that we helped (in a very small part) to create your 8th world wonder. We would like the opportunity to feature your device on our homepage.</description>
<packages>
<package name="EIA7343">
<description>EIA 7343 tantalum capacitor</description>
<wire x1="-5" y1="2.5" x2="-2" y2="2.5" width="0.2032" layer="21"/>
<wire x1="-5" y1="2.5" x2="-5" y2="-2.5" width="0.2032" layer="21"/>
<wire x1="-5" y1="-2.5" x2="-2" y2="-2.5" width="0.2032" layer="21"/>
<wire x1="2" y1="2.5" x2="4" y2="2.5" width="0.2032" layer="21"/>
<wire x1="4" y1="2.5" x2="5" y2="1.5" width="0.2032" layer="21"/>
<wire x1="5" y1="1.5" x2="5" y2="-1.5" width="0.2032" layer="21"/>
<wire x1="5" y1="-1.5" x2="4" y2="-2.5" width="0.2032" layer="21"/>
<wire x1="4" y1="-2.5" x2="2" y2="-2.5" width="0.2032" layer="21"/>
<smd name="C" x="-3.17" y="0" dx="2.55" dy="2.7" layer="1" rot="R180"/>
<smd name="A" x="3.17" y="0" dx="2.55" dy="2.7" layer="1" rot="R180"/>
<text x="0" y="2.667" size="0.6096" layer="25" font="vector" ratio="20" align="bottom-center">&gt;Name</text>
<text x="0" y="-2.667" size="0.6096" layer="27" font="vector" ratio="20" align="top-center">&gt;Value</text>
</package>
<package name="CPOL-RADIAL-2.5MM-6.5MM">
<description>2.5 mm spaced PTHs with 6.5 mm diameter outline</description>
<wire x1="-0.635" y1="1.778" x2="-1.905" y2="1.778" width="0.2032" layer="21"/>
<circle x="0" y="0" radius="3.25" width="0.2032" layer="21"/>
<pad name="2" x="-1.25" y="0" drill="0.7" diameter="1.651"/>
<pad name="1" x="1.25" y="0" drill="0.7" diameter="1.651" shape="square"/>
<text x="0" y="-3.429" size="0.6096" layer="27" font="vector" ratio="20" align="top-center">&gt;Value</text>
<text x="0" y="3.429" size="0.6096" layer="25" font="vector" ratio="20" align="bottom-center">&gt;Name</text>
<wire x1="1.905" y1="1.778" x2="0.635" y2="1.778" width="0.2032" layer="21"/>
<wire x1="1.27" y1="2.413" x2="1.27" y2="1.143" width="0.2032" layer="21"/>
</package>
<package name="NIC_10X10.5_CAP">
<description>Some old package in our library</description>
<smd name="+" x="4.5" y="0" dx="4.5" dy="2.5" layer="1"/>
<smd name="-" x="-4.5" y="0" dx="4.5" dy="2.5" layer="1"/>
<wire x1="-5.5" y1="-5.5" x2="3.5" y2="-5.5" width="0.2032" layer="21"/>
<wire x1="-5.5" y1="5.5" x2="3.5" y2="5.5" width="0.2032" layer="21"/>
<wire x1="3.5" y1="5.5" x2="5.5" y2="3.5" width="0.2032" layer="21"/>
<wire x1="5.5" y1="-3.5" x2="3.5" y2="-5.5" width="0.2032" layer="21"/>
<wire x1="-4.826" y1="1.524" x2="4.826" y2="1.397" width="0.2032" layer="21" curve="-147.716211"/>
<wire x1="-4.826" y1="-1.524" x2="4.826" y2="-1.397" width="0.2032" layer="21" curve="147.716211"/>
<wire x1="5.5" y1="3.5" x2="5.5" y2="1.5" width="0.2032" layer="21"/>
<wire x1="5.5" y1="-3.5" x2="5.5" y2="-1.5" width="0.2032" layer="21"/>
<wire x1="-5.5" y1="-5.5" x2="-5.5" y2="-1.5" width="0.2032" layer="21"/>
<wire x1="-5.5" y1="1.5" x2="-5.5" y2="5.5" width="0.2032" layer="21"/>
<text x="0" y="5.715" size="0.6096" layer="25" font="vector" ratio="20" align="bottom-center">&gt;NAME</text>
<text x="0" y="-5.715" size="0.6096" layer="27" font="vector" ratio="20" align="top-center">&gt;VALUE</text>
</package>
<package name="PANASONIC_D">
<description>&lt;b&gt;Panasonic Aluminium Electrolytic Capacitor VS-Serie Package E&lt;/b&gt;</description>
<wire x1="-3.25" y1="3.25" x2="1.55" y2="3.25" width="0.1016" layer="51"/>
<wire x1="1.55" y1="3.25" x2="3.25" y2="1.55" width="0.1016" layer="51"/>
<wire x1="3.25" y1="1.55" x2="3.25" y2="-1.55" width="0.1016" layer="51"/>
<wire x1="3.25" y1="-1.55" x2="1.55" y2="-3.25" width="0.1016" layer="51"/>
<wire x1="1.55" y1="-3.25" x2="-3.25" y2="-3.25" width="0.1016" layer="51"/>
<wire x1="-3.25" y1="-3.25" x2="-3.25" y2="3.25" width="0.1016" layer="51"/>
<wire x1="-3.25" y1="0.95" x2="-3.25" y2="3.25" width="0.1016" layer="21"/>
<wire x1="-3.25" y1="3.25" x2="1.55" y2="3.25" width="0.1016" layer="21"/>
<wire x1="1.55" y1="3.25" x2="3.25" y2="1.55" width="0.1016" layer="21"/>
<wire x1="3.25" y1="1.55" x2="3.25" y2="0.95" width="0.1016" layer="21"/>
<wire x1="3.25" y1="-0.95" x2="3.25" y2="-1.55" width="0.1016" layer="21"/>
<wire x1="3.25" y1="-1.55" x2="1.55" y2="-3.25" width="0.1016" layer="21"/>
<wire x1="1.55" y1="-3.25" x2="-3.25" y2="-3.25" width="0.1016" layer="21"/>
<wire x1="-3.25" y1="-3.25" x2="-3.25" y2="-0.95" width="0.1016" layer="21"/>
<wire x1="2.95" y1="0.95" x2="-2.95" y2="0.95" width="0.1016" layer="21" curve="144.299363"/>
<wire x1="-2.95" y1="-0.95" x2="2.95" y2="-0.95" width="0.1016" layer="21" curve="144.299363"/>
<wire x1="-2.1" y1="2.25" x2="-2.1" y2="-2.2" width="0.1016" layer="51"/>
<circle x="0" y="0" radius="3.1" width="0.1016" layer="51"/>
<smd name="+" x="2.4" y="0" dx="3" dy="1.4" layer="1"/>
<smd name="-" x="-2.4" y="0" dx="3" dy="1.4" layer="1"/>
<text x="0" y="3.429" size="0.6096" layer="25" font="vector" ratio="20" align="bottom-center">&gt;NAME</text>
<text x="0" y="-3.429" size="0.6096" layer="27" font="vector" ratio="20" align="top-center">&gt;VALUE</text>
<rectangle x1="-3.65" y1="-0.35" x2="-3.05" y2="0.35" layer="51"/>
<rectangle x1="3.05" y1="-0.35" x2="3.65" y2="0.35" layer="51"/>
<polygon width="0.1016" layer="51">
<vertex x="-2.15" y="2.15"/>
<vertex x="-2.6" y="1.6"/>
<vertex x="-2.9" y="0.9"/>
<vertex x="-3.05" y="0"/>
<vertex x="-2.9" y="-0.95"/>
<vertex x="-2.55" y="-1.65"/>
<vertex x="-2.15" y="-2.15"/>
<vertex x="-2.15" y="2.1"/>
</polygon>
</package>
</packages>
<symbols>
<symbol name="CAP_POL">
<wire x1="-2.54" y1="0" x2="2.54" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="-1.016" x2="0" y2="-2.54" width="0.1524" layer="94"/>
<wire x1="0" y1="-1" x2="2.4892" y2="-1.8542" width="0.254" layer="94" curve="-37.878202" cap="flat"/>
<wire x1="-2.4669" y1="-1.8504" x2="0" y2="-1.0161" width="0.254" layer="94" curve="-37.376341" cap="flat"/>
<text x="1.016" y="0.635" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="1.016" y="-4.191" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<rectangle x1="-2.253" y1="0.668" x2="-1.364" y2="0.795" layer="94"/>
<rectangle x1="-1.872" y1="0.287" x2="-1.745" y2="1.176" layer="94"/>
<pin name="+" x="0" y="2.54" visible="off" length="short" direction="pas" swaplevel="1" rot="R270"/>
<pin name="-" x="0" y="-5.08" visible="off" length="short" direction="pas" swaplevel="1" rot="R90"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="100UF-POLAR" prefix="C">
<description>&lt;h3&gt;100µF polarized capacitors&lt;/h3&gt;
&lt;p&gt;A capacitor is a passive two-terminal electrical component used to store electrical energy temporarily in an electric field.&lt;/p&gt;</description>
<gates>
<gate name="G$1" symbol="CAP_POL" x="0" y="0"/>
</gates>
<devices>
<device name="-EIA7343-10V-10%(TANT)" package="EIA7343">
<connects>
<connect gate="G$1" pin="+" pad="A"/>
<connect gate="G$1" pin="-" pad="C"/>
</connects>
<technologies>
<technology name="">
<attribute name="PROD_ID" value="CAP-07890"/>
<attribute name="VALUE" value="100uF"/>
</technology>
</technologies>
</device>
<device name="-EIA7343-16V-10%(TANT)" package="EIA7343">
<connects>
<connect gate="G$1" pin="+" pad="A"/>
<connect gate="G$1" pin="-" pad="C"/>
</connects>
<technologies>
<technology name="">
<attribute name="PROD_ID" value="CAP-08702"/>
<attribute name="VALUE" value="100uF"/>
</technology>
</technologies>
</device>
<device name="-RADIAL-2.5MM-25V-20%" package="CPOL-RADIAL-2.5MM-6.5MM">
<connects>
<connect gate="G$1" pin="+" pad="1"/>
<connect gate="G$1" pin="-" pad="2"/>
</connects>
<technologies>
<technology name="">
<attribute name="PROD_ID" value="CAP-08439"/>
<attribute name="VALUE" value="100uF"/>
</technology>
</technologies>
</device>
<device name="-10X10.5-63V-20%" package="NIC_10X10.5_CAP">
<connects>
<connect gate="G$1" pin="+" pad="+"/>
<connect gate="G$1" pin="-" pad="-"/>
</connects>
<technologies>
<technology name="">
<attribute name="PROD_ID" value="CAP-08362"/>
<attribute name="VALUE" value="100uF"/>
</technology>
</technologies>
</device>
<device name="-25V-20%(ELEC)" package="PANASONIC_D">
<connects>
<connect gate="G$1" pin="+" pad="+"/>
<connect gate="G$1" pin="-" pad="-"/>
</connects>
<technologies>
<technology name="">
<attribute name="PROD_ID" value="CAP-12547" constant="no"/>
<attribute name="VALUE" value="100uF" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="Adafruit">
<packages>
<package name="ADAFRUIT_ADXL335">
<wire x1="0" y1="0" x2="19.05" y2="0" width="0.127" layer="21"/>
<wire x1="19.05" y1="0" x2="19.05" y2="-19.05" width="0.127" layer="21"/>
<wire x1="19.05" y1="-19.05" x2="0" y2="-19.05" width="0.127" layer="21"/>
<wire x1="0" y1="-19.05" x2="0" y2="0" width="0.127" layer="21"/>
<pad name="VIN" x="1.905" y="-16.51" drill="1.016" diameter="1.778"/>
<pad name="3.3V" x="4.445" y="-16.51" drill="1.016" diameter="1.778"/>
<pad name="GND" x="6.985" y="-16.51" drill="1.016" diameter="1.778"/>
<pad name="ZOUT" x="9.525" y="-16.51" drill="1.016" diameter="1.778"/>
<pad name="YOUT" x="12.065" y="-16.51" drill="1.016" diameter="1.778"/>
<pad name="XOUT" x="14.605" y="-16.51" drill="1.016" diameter="1.778"/>
<pad name="TEST" x="17.145" y="-16.51" drill="1.016" diameter="1.778"/>
<pad name="P$8" x="2.54" y="-2.54" drill="2.032"/>
<pad name="P$9" x="16.51" y="-2.54" drill="2.032"/>
<text x="0" y="-21.59" size="1.27" layer="27">&gt;VALUE</text>
<text x="0" y="1.27" size="1.27" layer="25">&gt;NAME</text>
</package>
</packages>
<symbols>
<symbol name="ADAFRUIT_ADXL335">
<pin name="VIN" x="0" y="0" length="middle"/>
<pin name="3.3V" x="0" y="-5.08" length="middle"/>
<pin name="GND" x="0" y="-10.16" length="middle"/>
<pin name="ZOUT" x="0" y="-15.24" length="middle"/>
<pin name="YOUT" x="0" y="-20.32" length="middle"/>
<pin name="XOUT" x="0" y="-25.4" length="middle"/>
<pin name="TEST" x="0" y="-30.48" length="middle"/>
<wire x1="5.08" y1="-35.56" x2="5.08" y2="5.08" width="0.254" layer="94"/>
<wire x1="5.08" y1="5.08" x2="20.32" y2="5.08" width="0.254" layer="94"/>
<wire x1="20.32" y1="5.08" x2="20.32" y2="-35.56" width="0.254" layer="94"/>
<wire x1="20.32" y1="-35.56" x2="5.08" y2="-35.56" width="0.254" layer="94"/>
<text x="5.08" y="7.62" size="1.778" layer="95">&gt;NAME</text>
<text x="5.08" y="-40.64" size="1.778" layer="96">&gt;VALUE</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="ADAFRUIT_ADXL335">
<gates>
<gate name="G$1" symbol="ADAFRUIT_ADXL335" x="0" y="0"/>
</gates>
<devices>
<device name="" package="ADAFRUIT_ADXL335">
<connects>
<connect gate="G$1" pin="3.3V" pad="3.3V"/>
<connect gate="G$1" pin="GND" pad="GND"/>
<connect gate="G$1" pin="TEST" pad="TEST"/>
<connect gate="G$1" pin="VIN" pad="VIN"/>
<connect gate="G$1" pin="XOUT" pad="XOUT"/>
<connect gate="G$1" pin="YOUT" pad="YOUT"/>
<connect gate="G$1" pin="ZOUT" pad="ZOUT"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="19pinheader">
<packages>
<package name="19PINHEADER">
<pad name="P$1" x="0" y="0" drill="1.016" diameter="1.778"/>
<pad name="P$2" x="0" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$3" x="0" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$4" x="0" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$5" x="0" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$6" x="0" y="-12.7" drill="1.016" diameter="1.778"/>
<pad name="P$7" x="0" y="-15.24" drill="1.016" diameter="1.778"/>
<pad name="P$8" x="0" y="-17.78" drill="1.016" diameter="1.778"/>
<pad name="P$9" x="0" y="-20.32" drill="1.016" diameter="1.778"/>
<pad name="P$10" x="0" y="-22.86" drill="1.016" diameter="1.778"/>
<pad name="P$11" x="0" y="-25.4" drill="1.016" diameter="1.778"/>
<pad name="P$12" x="0" y="-27.94" drill="1.016" diameter="1.778"/>
<pad name="P$13" x="0" y="-30.48" drill="1.016" diameter="1.778"/>
<pad name="P$14" x="0" y="-33.02" drill="1.016" diameter="1.778"/>
<pad name="P$15" x="0" y="-35.56" drill="1.016" diameter="1.778"/>
<pad name="P$16" x="0" y="-38.1" drill="1.016" diameter="1.778"/>
<pad name="P$17" x="0" y="-40.64" drill="1.016" diameter="1.778"/>
<pad name="P$18" x="0" y="-43.18" drill="1.016" diameter="1.778"/>
<pad name="P$19" x="0" y="-45.72" drill="1.016" diameter="1.778"/>
</package>
</packages>
<symbols>
<symbol name="19PINHEADER">
<pin name="P$1" x="0" y="0" length="middle"/>
<pin name="P$2" x="0" y="-5.08" length="middle"/>
<pin name="P$3" x="0" y="-10.16" length="middle"/>
<pin name="P$4" x="0" y="-15.24" length="middle"/>
<pin name="P$5" x="0" y="-20.32" length="middle"/>
<pin name="P$6" x="0" y="-25.4" length="middle"/>
<pin name="P$7" x="0" y="-30.48" length="middle"/>
<pin name="P$8" x="0" y="-35.56" length="middle"/>
<pin name="P$9" x="0" y="-40.64" length="middle"/>
<pin name="P$10" x="0" y="-45.72" length="middle"/>
<pin name="P$11" x="0" y="-50.8" length="middle"/>
<pin name="P$12" x="0" y="-55.88" length="middle"/>
<pin name="P$13" x="0" y="-60.96" length="middle"/>
<pin name="P$14" x="0" y="-66.04" length="middle"/>
<pin name="P$15" x="0" y="-71.12" length="middle"/>
<pin name="P$16" x="0" y="-76.2" length="middle"/>
<pin name="P$17" x="0" y="-81.28" length="middle"/>
<pin name="P$18" x="0" y="-86.36" length="middle"/>
<pin name="P$19" x="0" y="-91.44" length="middle"/>
<wire x1="5.08" y1="-96.52" x2="5.08" y2="5.08" width="0.254" layer="94"/>
<wire x1="5.08" y1="5.08" x2="12.7" y2="5.08" width="0.254" layer="94"/>
<wire x1="12.7" y1="5.08" x2="12.7" y2="-96.52" width="0.254" layer="94"/>
<wire x1="12.7" y1="-96.52" x2="5.08" y2="-96.52" width="0.254" layer="94"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="19PINHEADER">
<gates>
<gate name="G$1" symbol="19PINHEADER" x="0" y="0"/>
</gates>
<devices>
<device name="" package="19PINHEADER">
<connects>
<connect gate="G$1" pin="P$1" pad="P$1"/>
<connect gate="G$1" pin="P$10" pad="P$10"/>
<connect gate="G$1" pin="P$11" pad="P$11"/>
<connect gate="G$1" pin="P$12" pad="P$12"/>
<connect gate="G$1" pin="P$13" pad="P$13"/>
<connect gate="G$1" pin="P$14" pad="P$14"/>
<connect gate="G$1" pin="P$15" pad="P$15"/>
<connect gate="G$1" pin="P$16" pad="P$16"/>
<connect gate="G$1" pin="P$17" pad="P$17"/>
<connect gate="G$1" pin="P$18" pad="P$18"/>
<connect gate="G$1" pin="P$19" pad="P$19"/>
<connect gate="G$1" pin="P$2" pad="P$2"/>
<connect gate="G$1" pin="P$3" pad="P$3"/>
<connect gate="G$1" pin="P$4" pad="P$4"/>
<connect gate="G$1" pin="P$5" pad="P$5"/>
<connect gate="G$1" pin="P$6" pad="P$6"/>
<connect gate="G$1" pin="P$7" pad="P$7"/>
<connect gate="G$1" pin="P$8" pad="P$8"/>
<connect gate="G$1" pin="P$9" pad="P$9"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="ScrewTerminals">
<packages>
<package name="2.54MM_3P">
<pad name="P$1" x="0" y="0" drill="1.016" diameter="1.778"/>
<pad name="P$2" x="0" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$3" x="0" y="-5.08" drill="1.016" diameter="1.778"/>
<wire x1="2.95" y1="1.5" x2="2.95" y2="-6.58" width="0.127" layer="21"/>
<wire x1="2.95" y1="-6.58" x2="-3.35" y2="-6.58" width="0.127" layer="21"/>
<wire x1="-3.35" y1="-6.58" x2="-3.35" y2="-5.97" width="0.127" layer="21"/>
<wire x1="-3.35" y1="-5.97" x2="-3.35" y2="-4.19" width="0.127" layer="21"/>
<wire x1="-3.35" y1="-4.19" x2="-3.35" y2="-3.43" width="0.127" layer="21"/>
<wire x1="-3.35" y1="-3.43" x2="-3.35" y2="-1.65" width="0.127" layer="21"/>
<wire x1="-3.35" y1="-1.65" x2="-3.35" y2="-0.89" width="0.127" layer="21"/>
<wire x1="-3.35" y1="-0.89" x2="-3.35" y2="0.89" width="0.127" layer="21"/>
<wire x1="-3.35" y1="0.89" x2="-3.35" y2="1.5" width="0.127" layer="21"/>
<wire x1="-3.35" y1="1.5" x2="2.95" y2="1.5" width="0.127" layer="21"/>
<wire x1="0" y1="-4.19" x2="-3.35" y2="-4.19" width="0.127" layer="21"/>
<wire x1="0" y1="-5.97" x2="-3.35" y2="-5.97" width="0.127" layer="21"/>
<wire x1="0" y1="-3.43" x2="-3.35" y2="-3.43" width="0.127" layer="21"/>
<wire x1="0" y1="-1.65" x2="-3.35" y2="-1.65" width="0.127" layer="21"/>
<wire x1="0" y1="-0.89" x2="-3.35" y2="-0.89" width="0.127" layer="21"/>
<wire x1="0" y1="0.89" x2="-3.35" y2="0.89" width="0.127" layer="21"/>
<text x="-2.54" y="2.54" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-10.16" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="2.54MM_2P">
<pad name="P$1" x="0" y="0" drill="1.016" diameter="1.778"/>
<pad name="P$2" x="0" y="-2.54" drill="1.016" diameter="1.778"/>
<wire x1="0" y1="0.89" x2="-3.35" y2="0.89" width="0.127" layer="21"/>
<wire x1="0" y1="-0.89" x2="-3.35" y2="-0.89" width="0.127" layer="21"/>
<wire x1="0" y1="-1.65" x2="-3.35" y2="-1.65" width="0.127" layer="21"/>
<wire x1="0" y1="-3.43" x2="-3.35" y2="-3.43" width="0.127" layer="21"/>
<text x="-3.81" y="2.54" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.81" y="-6.35" size="1.27" layer="27">&gt;VALUE</text>
<wire x1="2.95" y1="1.5" x2="2.95" y2="-4.04" width="0.127" layer="21"/>
<wire x1="2.95" y1="-4.04" x2="-3.35" y2="-4.04" width="0.127" layer="21"/>
<wire x1="-3.35" y1="-4.04" x2="-3.35" y2="1.5" width="0.127" layer="21"/>
<wire x1="-3.35" y1="1.5" x2="2.95" y2="1.5" width="0.127" layer="21"/>
</package>
</packages>
<symbols>
<symbol name="2.54MM_3P">
<pin name="P$1" x="0" y="0" length="middle"/>
<pin name="P$2" x="0" y="-2.54" length="middle"/>
<pin name="P$3" x="0" y="-5.08" length="middle"/>
<wire x1="5.08" y1="-7.62" x2="5.08" y2="2.54" width="0.254" layer="94"/>
<wire x1="5.08" y1="2.54" x2="12.7" y2="2.54" width="0.254" layer="94"/>
<wire x1="12.7" y1="2.54" x2="12.7" y2="-7.62" width="0.254" layer="94"/>
<wire x1="12.7" y1="-7.62" x2="5.08" y2="-7.62" width="0.254" layer="94"/>
<text x="5.08" y="5.08" size="1.778" layer="95">&gt;NAME</text>
<text x="5.08" y="-12.7" size="1.778" layer="96">&gt;VALUE</text>
</symbol>
<symbol name="2.54MM_2P">
<pin name="P$1" x="0" y="0" length="middle"/>
<pin name="P$2" x="0" y="-2.54" length="middle"/>
<wire x1="5.08" y1="-5.08" x2="5.08" y2="2.54" width="0.254" layer="94"/>
<wire x1="5.08" y1="2.54" x2="12.7" y2="2.54" width="0.254" layer="94"/>
<wire x1="12.7" y1="2.54" x2="12.7" y2="-5.08" width="0.254" layer="94"/>
<wire x1="12.7" y1="-5.08" x2="5.08" y2="-5.08" width="0.254" layer="94"/>
<text x="5.08" y="5.08" size="1.778" layer="95">&gt;NAME</text>
<text x="5.08" y="-10.16" size="1.778" layer="96">&gt;VALUE</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="2.54MM_3P">
<gates>
<gate name="G$1" symbol="2.54MM_3P" x="0" y="0"/>
</gates>
<devices>
<device name="" package="2.54MM_3P">
<connects>
<connect gate="G$1" pin="P$1" pad="P$1"/>
<connect gate="G$1" pin="P$2" pad="P$2"/>
<connect gate="G$1" pin="P$3" pad="P$3"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="2.54MM_2P">
<gates>
<gate name="G$1" symbol="2.54MM_2P" x="0" y="0"/>
</gates>
<devices>
<device name="" package="2.54MM_2P">
<connects>
<connect gate="G$1" pin="P$1" pad="P$1"/>
<connect gate="G$1" pin="P$2" pad="P$2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="POLOLU">
<packages>
<package name="DRV8834">
<pad name="ENABLE" x="0" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="M0" x="0" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="M1" x="0" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="CONFIG" x="0" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="VREF" x="0" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="SLEEP" x="0" y="-12.7" drill="1.016" diameter="1.778"/>
<pad name="STEP" x="0" y="-15.24" drill="1.016" diameter="1.778"/>
<pad name="DIR" x="0" y="-17.78" drill="1.016" diameter="1.778"/>
<pad name="GND@2" x="12.7" y="-17.78" drill="1.016" diameter="1.778"/>
<pad name="FAULT" x="12.7" y="-15.24" drill="1.016" diameter="1.778"/>
<pad name="A2" x="12.7" y="-12.7" drill="1.016" diameter="1.778"/>
<pad name="A1" x="12.7" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="B1" x="12.7" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="B2" x="12.7" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="GND@1" x="12.7" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="VMOT" x="12.7" y="0" drill="1.016" diameter="1.778"/>
<wire x1="-1.27" y1="1.27" x2="13.97" y2="1.27" width="0.127" layer="25"/>
<wire x1="13.97" y1="1.27" x2="13.97" y2="-19.05" width="0.127" layer="25"/>
<wire x1="13.97" y1="-19.05" x2="-1.27" y2="-19.05" width="0.127" layer="25"/>
<wire x1="-1.27" y1="-19.05" x2="-1.27" y2="1.27" width="0.127" layer="25"/>
</package>
</packages>
<symbols>
<symbol name="DRV8834">
<pin name="ENABLE" x="0" y="0" length="middle"/>
<pin name="M0" x="0" y="-5.08" length="middle"/>
<pin name="M1" x="0" y="-10.16" length="middle"/>
<pin name="CONFIG" x="0" y="-15.24" length="middle"/>
<pin name="VREF" x="0" y="-20.32" length="middle"/>
<pin name="SLEEP" x="0" y="-25.4" length="middle"/>
<pin name="STEP" x="0" y="-30.48" length="middle"/>
<pin name="DIR" x="0" y="-35.56" length="middle"/>
<pin name="VMOT" x="30.48" y="0" length="middle" rot="R180"/>
<pin name="GND@1" x="30.48" y="-5.08" length="middle" rot="R180"/>
<pin name="B2" x="30.48" y="-10.16" length="middle" rot="R180"/>
<pin name="B1" x="30.48" y="-15.24" length="middle" rot="R180"/>
<pin name="A1" x="30.48" y="-20.32" length="middle" rot="R180"/>
<pin name="A2" x="30.48" y="-25.4" length="middle" rot="R180"/>
<pin name="FAULT" x="30.48" y="-30.48" length="middle" rot="R180"/>
<pin name="GND@2" x="30.48" y="-35.56" length="middle" rot="R180"/>
<wire x1="5.08" y1="-38.1" x2="5.08" y2="2.54" width="0.254" layer="94"/>
<wire x1="5.08" y1="2.54" x2="25.4" y2="2.54" width="0.254" layer="94"/>
<wire x1="25.4" y1="2.54" x2="25.4" y2="-38.1" width="0.254" layer="94"/>
<wire x1="25.4" y1="-38.1" x2="5.08" y2="-38.1" width="0.254" layer="94"/>
<text x="5.08" y="5.08" size="1.778" layer="95">&gt;NAME</text>
<text x="5.08" y="-43.18" size="1.778" layer="96">&gt;VALUE</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="DRV8834">
<gates>
<gate name="G$1" symbol="DRV8834" x="0" y="0"/>
</gates>
<devices>
<device name="" package="DRV8834">
<connects>
<connect gate="G$1" pin="A1" pad="A1"/>
<connect gate="G$1" pin="A2" pad="A2"/>
<connect gate="G$1" pin="B1" pad="B1"/>
<connect gate="G$1" pin="B2" pad="B2"/>
<connect gate="G$1" pin="CONFIG" pad="CONFIG"/>
<connect gate="G$1" pin="DIR" pad="DIR"/>
<connect gate="G$1" pin="ENABLE" pad="ENABLE"/>
<connect gate="G$1" pin="FAULT" pad="FAULT"/>
<connect gate="G$1" pin="GND@1" pad="GND@1"/>
<connect gate="G$1" pin="GND@2" pad="GND@2"/>
<connect gate="G$1" pin="M0" pad="M0"/>
<connect gate="G$1" pin="M1" pad="M1"/>
<connect gate="G$1" pin="SLEEP" pad="SLEEP"/>
<connect gate="G$1" pin="STEP" pad="STEP"/>
<connect gate="G$1" pin="VMOT" pad="VMOT"/>
<connect gate="G$1" pin="VREF" pad="VREF"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="PerfBoard">
<packages>
<package name="PERFBOARD_CONVEYOR">
<pad name="P$1" x="0" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$2" x="2.54" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$3" x="5.08" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$4" x="7.62" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$5" x="10.16" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$6" x="12.7" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$7" x="15.24" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$8" x="17.78" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$9" x="20.32" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$10" x="22.86" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$11" x="25.4" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$12" x="27.94" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$13" x="30.48" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$14" x="33.02" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$15" x="35.56" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$16" x="38.1" y="0" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$17" x="0" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$18" x="2.54" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$19" x="5.08" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$20" x="7.62" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$21" x="10.16" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$22" x="12.7" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$23" x="15.24" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$24" x="17.78" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$25" x="20.32" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$26" x="22.86" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$27" x="25.4" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$28" x="27.94" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$29" x="30.48" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$30" x="33.02" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$31" x="35.56" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$32" x="38.1" y="-2.54" drill="1.016" diameter="1.778"/>
<pad name="P$33" x="38.1" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$34" x="35.56" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$35" x="33.02" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$36" x="30.48" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$37" x="27.94" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$38" x="25.4" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$39" x="22.86" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$40" x="20.32" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$41" x="17.78" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$42" x="15.24" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$43" x="12.7" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$44" x="10.16" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$45" x="7.62" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$46" x="5.08" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$47" x="2.54" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$48" x="0" y="-5.08" drill="1.016" diameter="1.778"/>
<pad name="P$49" x="0" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$50" x="2.54" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$51" x="5.08" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$52" x="7.62" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$53" x="10.16" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$54" x="12.7" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$55" x="15.24" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$56" x="17.78" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$57" x="20.32" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$58" x="22.86" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$59" x="25.4" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$60" x="27.94" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$61" x="30.48" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$62" x="33.02" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$63" x="35.56" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$64" x="38.1" y="-7.62" drill="1.016" diameter="1.778"/>
<pad name="P$65" x="38.1" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$66" x="35.56" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$67" x="33.02" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$68" x="30.48" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$69" x="27.94" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$70" x="25.4" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$71" x="22.86" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$72" x="20.32" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$73" x="17.78" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$74" x="15.24" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$75" x="12.7" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$76" x="10.16" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$77" x="7.62" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$78" x="5.08" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$79" x="2.54" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$80" x="0" y="-10.16" drill="1.016" diameter="1.778"/>
<pad name="P$81" x="0" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$82" x="2.54" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$83" x="5.08" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$84" x="7.62" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$85" x="10.16" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$86" x="12.7" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$87" x="15.24" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$88" x="17.78" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$89" x="20.32" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$90" x="22.86" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$91" x="25.4" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$92" x="27.94" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$93" x="30.48" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$94" x="33.02" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$95" x="35.56" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
<pad name="P$96" x="38.1" y="-12.7" drill="1.016" diameter="1.778" shape="square"/>
</package>
</packages>
<symbols>
<symbol name="PERFBOARD_CONVEYOR">
<pin name="P$1" x="0" y="0" length="middle"/>
<pin name="P$2" x="0" y="-2.54" length="middle"/>
<pin name="P$3" x="0" y="-5.08" length="middle"/>
<pin name="P$4" x="0" y="-7.62" length="middle"/>
<pin name="P$5" x="0" y="-10.16" length="middle"/>
<pin name="P$6" x="0" y="-12.7" length="middle"/>
<pin name="P$7" x="0" y="-15.24" length="middle"/>
<pin name="P$8" x="0" y="-17.78" length="middle"/>
<pin name="P$9" x="0" y="-20.32" length="middle"/>
<pin name="P$10" x="0" y="-22.86" length="middle"/>
<pin name="P$11" x="0" y="-25.4" length="middle"/>
<pin name="P$12" x="0" y="-27.94" length="middle"/>
<pin name="P$13" x="0" y="-30.48" length="middle"/>
<pin name="P$14" x="0" y="-33.02" length="middle"/>
<pin name="P$15" x="0" y="-35.56" length="middle"/>
<pin name="P$16" x="0" y="-38.1" length="middle"/>
<pin name="P$17" x="-15.24" y="0" length="middle"/>
<pin name="P$18" x="-15.24" y="-2.54" length="middle"/>
<pin name="P$19" x="-15.24" y="-5.08" length="middle"/>
<pin name="P$20" x="-15.24" y="-7.62" length="middle"/>
<pin name="P$21" x="-15.24" y="-10.16" length="middle"/>
<pin name="P$22" x="-15.24" y="-12.7" length="middle"/>
<pin name="P$23" x="-15.24" y="-15.24" length="middle"/>
<pin name="P$24" x="-15.24" y="-17.78" length="middle"/>
<pin name="P$25" x="-15.24" y="-20.32" length="middle"/>
<pin name="P$26" x="-15.24" y="-22.86" length="middle"/>
<pin name="P$27" x="-15.24" y="-25.4" length="middle"/>
<pin name="P$28" x="-15.24" y="-27.94" length="middle"/>
<pin name="P$29" x="-15.24" y="-30.48" length="middle"/>
<pin name="P$30" x="-15.24" y="-33.02" length="middle"/>
<pin name="P$31" x="-15.24" y="-35.56" length="middle"/>
<pin name="P$32" x="-15.24" y="-38.1" length="middle"/>
<pin name="P$33" x="-33.02" y="0" length="middle"/>
<pin name="P$34" x="-33.02" y="-2.54" length="middle"/>
<pin name="P$35" x="-33.02" y="-5.08" length="middle"/>
<pin name="P$36" x="-33.02" y="-7.62" length="middle"/>
<pin name="P$37" x="-33.02" y="-10.16" length="middle"/>
<pin name="P$38" x="-33.02" y="-12.7" length="middle"/>
<pin name="P$39" x="-33.02" y="-15.24" length="middle"/>
<pin name="P$40" x="-33.02" y="-17.78" length="middle"/>
<pin name="P$41" x="-33.02" y="-20.32" length="middle"/>
<pin name="P$42" x="-33.02" y="-22.86" length="middle"/>
<pin name="P$43" x="-33.02" y="-25.4" length="middle"/>
<pin name="P$44" x="-33.02" y="-27.94" length="middle"/>
<pin name="P$45" x="-33.02" y="-30.48" length="middle"/>
<pin name="P$46" x="-33.02" y="-33.02" length="middle"/>
<pin name="P$47" x="-33.02" y="-35.56" length="middle"/>
<pin name="P$48" x="-33.02" y="-38.1" length="middle"/>
<pin name="P$49" x="-50.8" y="0" length="middle"/>
<pin name="P$50" x="-50.8" y="-2.54" length="middle"/>
<pin name="P$51" x="-50.8" y="-5.08" length="middle"/>
<pin name="P$52" x="-50.8" y="-7.62" length="middle"/>
<pin name="P$53" x="-50.8" y="-10.16" length="middle"/>
<pin name="P$54" x="-50.8" y="-12.7" length="middle"/>
<pin name="P$55" x="-50.8" y="-15.24" length="middle"/>
<pin name="P$56" x="-50.8" y="-17.78" length="middle"/>
<pin name="P$57" x="-50.8" y="-20.32" length="middle"/>
<pin name="P$58" x="-50.8" y="-22.86" length="middle"/>
<pin name="P$59" x="-50.8" y="-25.4" length="middle"/>
<pin name="P$60" x="-50.8" y="-27.94" length="middle"/>
<pin name="P$61" x="-50.8" y="-30.48" length="middle"/>
<pin name="P$62" x="-50.8" y="-33.02" length="middle"/>
<pin name="P$63" x="-50.8" y="-35.56" length="middle"/>
<pin name="P$64" x="-50.8" y="-38.1" length="middle"/>
<pin name="P$65" x="-68.58" y="0" length="middle"/>
<pin name="P$66" x="-68.58" y="-2.54" length="middle"/>
<pin name="P$67" x="-68.58" y="-5.08" length="middle"/>
<pin name="P$68" x="-68.58" y="-7.62" length="middle"/>
<pin name="P$69" x="-68.58" y="-10.16" length="middle"/>
<pin name="P$70" x="-68.58" y="-12.7" length="middle"/>
<pin name="P$71" x="-68.58" y="-15.24" length="middle"/>
<pin name="P$72" x="-68.58" y="-17.78" length="middle"/>
<pin name="P$73" x="-68.58" y="-20.32" length="middle"/>
<pin name="P$74" x="-68.58" y="-22.86" length="middle"/>
<pin name="P$75" x="-68.58" y="-25.4" length="middle"/>
<pin name="P$76" x="-68.58" y="-27.94" length="middle"/>
<pin name="P$77" x="-68.58" y="-30.48" length="middle"/>
<pin name="P$78" x="-68.58" y="-33.02" length="middle"/>
<pin name="P$79" x="-68.58" y="-35.56" length="middle"/>
<pin name="P$80" x="-68.58" y="-38.1" length="middle"/>
<pin name="P$81" x="-86.36" y="0" length="middle"/>
<pin name="P$82" x="-86.36" y="-2.54" length="middle"/>
<pin name="P$83" x="-86.36" y="-5.08" length="middle"/>
<pin name="P$84" x="-86.36" y="-7.62" length="middle"/>
<pin name="P$85" x="-86.36" y="-10.16" length="middle"/>
<pin name="P$86" x="-86.36" y="-12.7" length="middle"/>
<pin name="P$87" x="-86.36" y="-15.24" length="middle"/>
<pin name="P$88" x="-86.36" y="-17.78" length="middle"/>
<pin name="P$89" x="-86.36" y="-20.32" length="middle"/>
<pin name="P$90" x="-86.36" y="-22.86" length="middle"/>
<pin name="P$91" x="-86.36" y="-25.4" length="middle"/>
<pin name="P$92" x="-86.36" y="-27.94" length="middle"/>
<pin name="P$93" x="-86.36" y="-30.48" length="middle"/>
<pin name="P$94" x="-86.36" y="-33.02" length="middle"/>
<pin name="P$95" x="-86.36" y="-35.56" length="middle"/>
<pin name="P$96" x="-86.36" y="-38.1" length="middle"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="PERFBOARD_CONVEYOR">
<gates>
<gate name="G$1" symbol="PERFBOARD_CONVEYOR" x="0" y="0"/>
</gates>
<devices>
<device name="" package="PERFBOARD_CONVEYOR">
<connects>
<connect gate="G$1" pin="P$1" pad="P$1"/>
<connect gate="G$1" pin="P$10" pad="P$10"/>
<connect gate="G$1" pin="P$11" pad="P$11"/>
<connect gate="G$1" pin="P$12" pad="P$12"/>
<connect gate="G$1" pin="P$13" pad="P$13"/>
<connect gate="G$1" pin="P$14" pad="P$14"/>
<connect gate="G$1" pin="P$15" pad="P$15"/>
<connect gate="G$1" pin="P$16" pad="P$16"/>
<connect gate="G$1" pin="P$17" pad="P$17"/>
<connect gate="G$1" pin="P$18" pad="P$18"/>
<connect gate="G$1" pin="P$19" pad="P$19"/>
<connect gate="G$1" pin="P$2" pad="P$2"/>
<connect gate="G$1" pin="P$20" pad="P$20"/>
<connect gate="G$1" pin="P$21" pad="P$21"/>
<connect gate="G$1" pin="P$22" pad="P$22"/>
<connect gate="G$1" pin="P$23" pad="P$23"/>
<connect gate="G$1" pin="P$24" pad="P$24"/>
<connect gate="G$1" pin="P$25" pad="P$25"/>
<connect gate="G$1" pin="P$26" pad="P$26"/>
<connect gate="G$1" pin="P$27" pad="P$27"/>
<connect gate="G$1" pin="P$28" pad="P$28"/>
<connect gate="G$1" pin="P$29" pad="P$29"/>
<connect gate="G$1" pin="P$3" pad="P$3"/>
<connect gate="G$1" pin="P$30" pad="P$30"/>
<connect gate="G$1" pin="P$31" pad="P$31"/>
<connect gate="G$1" pin="P$32" pad="P$32"/>
<connect gate="G$1" pin="P$33" pad="P$33"/>
<connect gate="G$1" pin="P$34" pad="P$34"/>
<connect gate="G$1" pin="P$35" pad="P$35"/>
<connect gate="G$1" pin="P$36" pad="P$36"/>
<connect gate="G$1" pin="P$37" pad="P$37"/>
<connect gate="G$1" pin="P$38" pad="P$38"/>
<connect gate="G$1" pin="P$39" pad="P$39"/>
<connect gate="G$1" pin="P$4" pad="P$4"/>
<connect gate="G$1" pin="P$40" pad="P$40"/>
<connect gate="G$1" pin="P$41" pad="P$41"/>
<connect gate="G$1" pin="P$42" pad="P$42"/>
<connect gate="G$1" pin="P$43" pad="P$43"/>
<connect gate="G$1" pin="P$44" pad="P$44"/>
<connect gate="G$1" pin="P$45" pad="P$45"/>
<connect gate="G$1" pin="P$46" pad="P$46"/>
<connect gate="G$1" pin="P$47" pad="P$47"/>
<connect gate="G$1" pin="P$48" pad="P$48"/>
<connect gate="G$1" pin="P$49" pad="P$49"/>
<connect gate="G$1" pin="P$5" pad="P$5"/>
<connect gate="G$1" pin="P$50" pad="P$50"/>
<connect gate="G$1" pin="P$51" pad="P$51"/>
<connect gate="G$1" pin="P$52" pad="P$52"/>
<connect gate="G$1" pin="P$53" pad="P$53"/>
<connect gate="G$1" pin="P$54" pad="P$54"/>
<connect gate="G$1" pin="P$55" pad="P$55"/>
<connect gate="G$1" pin="P$56" pad="P$56"/>
<connect gate="G$1" pin="P$57" pad="P$57"/>
<connect gate="G$1" pin="P$58" pad="P$58"/>
<connect gate="G$1" pin="P$59" pad="P$59"/>
<connect gate="G$1" pin="P$6" pad="P$6"/>
<connect gate="G$1" pin="P$60" pad="P$60"/>
<connect gate="G$1" pin="P$61" pad="P$61"/>
<connect gate="G$1" pin="P$62" pad="P$62"/>
<connect gate="G$1" pin="P$63" pad="P$63"/>
<connect gate="G$1" pin="P$64" pad="P$64"/>
<connect gate="G$1" pin="P$65" pad="P$65"/>
<connect gate="G$1" pin="P$66" pad="P$66"/>
<connect gate="G$1" pin="P$67" pad="P$67"/>
<connect gate="G$1" pin="P$68" pad="P$68"/>
<connect gate="G$1" pin="P$69" pad="P$69"/>
<connect gate="G$1" pin="P$7" pad="P$7"/>
<connect gate="G$1" pin="P$70" pad="P$70"/>
<connect gate="G$1" pin="P$71" pad="P$71"/>
<connect gate="G$1" pin="P$72" pad="P$72"/>
<connect gate="G$1" pin="P$73" pad="P$73"/>
<connect gate="G$1" pin="P$74" pad="P$74"/>
<connect gate="G$1" pin="P$75" pad="P$75"/>
<connect gate="G$1" pin="P$76" pad="P$76"/>
<connect gate="G$1" pin="P$77" pad="P$77"/>
<connect gate="G$1" pin="P$78" pad="P$78"/>
<connect gate="G$1" pin="P$79" pad="P$79"/>
<connect gate="G$1" pin="P$8" pad="P$8"/>
<connect gate="G$1" pin="P$80" pad="P$80"/>
<connect gate="G$1" pin="P$81" pad="P$81"/>
<connect gate="G$1" pin="P$82" pad="P$82"/>
<connect gate="G$1" pin="P$83" pad="P$83"/>
<connect gate="G$1" pin="P$84" pad="P$84"/>
<connect gate="G$1" pin="P$85" pad="P$85"/>
<connect gate="G$1" pin="P$86" pad="P$86"/>
<connect gate="G$1" pin="P$87" pad="P$87"/>
<connect gate="G$1" pin="P$88" pad="P$88"/>
<connect gate="G$1" pin="P$89" pad="P$89"/>
<connect gate="G$1" pin="P$9" pad="P$9"/>
<connect gate="G$1" pin="P$90" pad="P$90"/>
<connect gate="G$1" pin="P$91" pad="P$91"/>
<connect gate="G$1" pin="P$92" pad="P$92"/>
<connect gate="G$1" pin="P$93" pad="P$93"/>
<connect gate="G$1" pin="P$94" pad="P$94"/>
<connect gate="G$1" pin="P$95" pad="P$95"/>
<connect gate="G$1" pin="P$96" pad="P$96"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="Espressif">
<packages>
<package name="ESP32_DEV_KIT">
<wire x1="0" y1="0" x2="25.4" y2="0" width="0.127" layer="21"/>
<wire x1="25.4" y1="0" x2="25.4" y2="-48.26" width="0.127" layer="21"/>
<wire x1="25.4" y1="-48.26" x2="0" y2="-48.26" width="0.127" layer="21"/>
<wire x1="0" y1="-48.26" x2="0" y2="0" width="0.127" layer="21"/>
<pad name="VIN3.3V" x="1.27" y="-1.27" drill="1.016" diameter="1.778"/>
<pad name="EN" x="1.27" y="-3.81" drill="1.016" diameter="1.778"/>
<pad name="GPIO36" x="1.27" y="-6.35" drill="1.016" diameter="1.778"/>
<pad name="GPIO39" x="1.27" y="-8.89" drill="1.016" diameter="1.778"/>
<pad name="GPIO34" x="1.27" y="-11.43" drill="1.016" diameter="1.778"/>
<pad name="GPIO35" x="1.27" y="-13.97" drill="1.016" diameter="1.778"/>
<pad name="GPIO32" x="1.27" y="-16.51" drill="1.016" diameter="1.778"/>
<pad name="GPIO33" x="1.27" y="-19.05" drill="1.016" diameter="1.778"/>
<pad name="GPIO25" x="1.27" y="-21.59" drill="1.016" diameter="1.778"/>
<pad name="GPIO26" x="1.27" y="-24.13" drill="1.016" diameter="1.778"/>
<pad name="GPIO27" x="1.27" y="-26.67" drill="1.016" diameter="1.778"/>
<pad name="GPIO14" x="1.27" y="-29.21" drill="1.016" diameter="1.778"/>
<pad name="GPIO12" x="1.27" y="-31.75" drill="1.016" diameter="1.778"/>
<pad name="GND@1" x="1.27" y="-34.29" drill="1.016" diameter="1.778"/>
<pad name="GPIO13" x="1.27" y="-36.83" drill="1.016" diameter="1.778"/>
<pad name="GPIO10" x="1.27" y="-41.91" drill="1.016" diameter="1.778"/>
<pad name="GPIO11" x="1.27" y="-44.45" drill="1.016" diameter="1.778"/>
<pad name="VIN5V" x="1.27" y="-46.99" drill="1.016" diameter="1.778"/>
<pad name="GND@2" x="24.13" y="-1.27" drill="1.016" diameter="1.778"/>
<pad name="GPIO23" x="24.13" y="-3.81" drill="1.016" diameter="1.778"/>
<pad name="GPIO22" x="24.13" y="-6.35" drill="1.016" diameter="1.778"/>
<pad name="GPIO1" x="24.13" y="-8.89" drill="1.016" diameter="1.778"/>
<pad name="GPIO3" x="24.13" y="-11.43" drill="1.016" diameter="1.778"/>
<pad name="GPIO21" x="24.13" y="-13.97" drill="1.016" diameter="1.778"/>
<pad name="GND@3" x="24.13" y="-16.51" drill="1.016" diameter="1.778"/>
<pad name="GPIO19" x="24.13" y="-19.05" drill="1.016" diameter="1.778"/>
<pad name="GPIO18" x="24.13" y="-21.59" drill="1.016" diameter="1.778"/>
<pad name="GPIO5" x="24.13" y="-24.13" drill="1.016" diameter="1.778"/>
<pad name="GPIO17" x="24.13" y="-26.67" drill="1.016" diameter="1.778"/>
<pad name="GPIO16" x="24.13" y="-29.21" drill="1.016" diameter="1.778"/>
<pad name="GPIO4" x="24.13" y="-31.75" drill="1.016" diameter="1.778"/>
<pad name="GPIO0" x="24.13" y="-34.29" drill="1.016" diameter="1.778"/>
<pad name="GPIO2" x="24.13" y="-36.83" drill="1.016" diameter="1.778"/>
<pad name="GPIO8" x="24.13" y="-41.91" drill="1.016" diameter="1.778"/>
<pad name="GPIO7" x="24.13" y="-44.45" drill="1.016" diameter="1.778"/>
<pad name="GPIO6" x="24.13" y="-46.99" drill="1.016" diameter="1.778"/>
<pad name="GPIO9" x="1.27" y="-39.37" drill="1.016" diameter="1.778" shape="square"/>
<pad name="GPIO15" x="24.13" y="-39.37" drill="1.016" diameter="1.778" shape="square"/>
<text x="0" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="0" y="-50.8" size="1.27" layer="27">&gt;VALUE</text>
</package>
</packages>
<symbols>
<symbol name="ESP32_DEV_KIT">
<pin name="VIN3.3V" x="0" y="0" length="middle"/>
<pin name="EN" x="0" y="-5.08" length="middle"/>
<pin name="GPIO36" x="0" y="-10.16" length="middle"/>
<pin name="GPIO39" x="0" y="-15.24" length="middle"/>
<pin name="GPIO34" x="0" y="-20.32" length="middle"/>
<pin name="GPIO35" x="0" y="-25.4" length="middle"/>
<pin name="GPIO32" x="0" y="-30.48" length="middle"/>
<pin name="GPIO33" x="0" y="-35.56" length="middle"/>
<pin name="GPIO25" x="0" y="-40.64" length="middle"/>
<pin name="GPIO26" x="0" y="-45.72" length="middle"/>
<pin name="GPIO27" x="0" y="-50.8" length="middle"/>
<pin name="GPIO14" x="0" y="-55.88" length="middle"/>
<pin name="GPIO12" x="0" y="-60.96" length="middle"/>
<pin name="GND@1" x="0" y="-66.04" length="middle"/>
<pin name="GPIO13" x="0" y="-71.12" length="middle"/>
<pin name="GPIO9" x="0" y="-76.2" length="middle"/>
<pin name="GPIO10" x="0" y="-81.28" length="middle"/>
<pin name="GPIO11" x="0" y="-86.36" length="middle"/>
<pin name="VIN5V" x="0" y="-91.44" length="middle"/>
<pin name="GPIO6" x="33.02" y="-91.44" length="middle" rot="R180"/>
<pin name="GPIO7" x="33.02" y="-86.36" length="middle" rot="R180"/>
<pin name="GPIO8" x="33.02" y="-81.28" length="middle" rot="R180"/>
<pin name="GPIO15" x="33.02" y="-76.2" length="middle" rot="R180"/>
<pin name="GPIO2" x="33.02" y="-71.12" length="middle" rot="R180"/>
<pin name="GPIO0" x="33.02" y="-66.04" length="middle" rot="R180"/>
<pin name="GPIO4" x="33.02" y="-60.96" length="middle" rot="R180"/>
<pin name="GPIO16" x="33.02" y="-55.88" length="middle" rot="R180"/>
<pin name="GPIO17" x="33.02" y="-50.8" length="middle" rot="R180"/>
<pin name="GPIO5" x="33.02" y="-45.72" length="middle" rot="R180"/>
<pin name="GPIO18" x="33.02" y="-40.64" length="middle" rot="R180"/>
<pin name="GPIO19" x="33.02" y="-35.56" length="middle" rot="R180"/>
<pin name="GND@3" x="33.02" y="-30.48" length="middle" rot="R180"/>
<pin name="GPIO21" x="33.02" y="-25.4" length="middle" rot="R180"/>
<pin name="GPIO3" x="33.02" y="-20.32" length="middle" rot="R180"/>
<pin name="GPIO1" x="33.02" y="-15.24" length="middle" rot="R180"/>
<pin name="GPIO22" x="33.02" y="-10.16" length="middle" rot="R180"/>
<pin name="GPIO23" x="33.02" y="-5.08" length="middle" rot="R180"/>
<pin name="GND@2" x="33.02" y="0" length="middle" rot="R180"/>
<wire x1="5.08" y1="-93.98" x2="5.08" y2="2.54" width="0.254" layer="94"/>
<wire x1="5.08" y1="2.54" x2="27.94" y2="2.54" width="0.254" layer="94"/>
<wire x1="27.94" y1="2.54" x2="27.94" y2="-93.98" width="0.254" layer="94"/>
<wire x1="27.94" y1="-93.98" x2="5.08" y2="-93.98" width="0.254" layer="94"/>
<text x="5.08" y="5.08" size="1.27" layer="95">&gt;NAME</text>
<text x="5.08" y="-99.06" size="1.27" layer="96">&gt;VALUE</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="ESP32_DEV_KIT" prefix="ESP32">
<gates>
<gate name="G$1" symbol="ESP32_DEV_KIT" x="0" y="0"/>
</gates>
<devices>
<device name="" package="ESP32_DEV_KIT">
<connects>
<connect gate="G$1" pin="EN" pad="EN"/>
<connect gate="G$1" pin="GND@1" pad="GND@1"/>
<connect gate="G$1" pin="GND@2" pad="GND@2"/>
<connect gate="G$1" pin="GND@3" pad="GND@3"/>
<connect gate="G$1" pin="GPIO0" pad="GPIO0"/>
<connect gate="G$1" pin="GPIO1" pad="GPIO1"/>
<connect gate="G$1" pin="GPIO10" pad="GPIO10"/>
<connect gate="G$1" pin="GPIO11" pad="GPIO11"/>
<connect gate="G$1" pin="GPIO12" pad="GPIO12"/>
<connect gate="G$1" pin="GPIO13" pad="GPIO13"/>
<connect gate="G$1" pin="GPIO14" pad="GPIO14"/>
<connect gate="G$1" pin="GPIO15" pad="GPIO15"/>
<connect gate="G$1" pin="GPIO16" pad="GPIO16"/>
<connect gate="G$1" pin="GPIO17" pad="GPIO17"/>
<connect gate="G$1" pin="GPIO18" pad="GPIO18"/>
<connect gate="G$1" pin="GPIO19" pad="GPIO19"/>
<connect gate="G$1" pin="GPIO2" pad="GPIO2"/>
<connect gate="G$1" pin="GPIO21" pad="GPIO21"/>
<connect gate="G$1" pin="GPIO22" pad="GPIO22"/>
<connect gate="G$1" pin="GPIO23" pad="GPIO23"/>
<connect gate="G$1" pin="GPIO25" pad="GPIO25"/>
<connect gate="G$1" pin="GPIO26" pad="GPIO26"/>
<connect gate="G$1" pin="GPIO27" pad="GPIO27"/>
<connect gate="G$1" pin="GPIO3" pad="GPIO3"/>
<connect gate="G$1" pin="GPIO32" pad="GPIO32"/>
<connect gate="G$1" pin="GPIO33" pad="GPIO33"/>
<connect gate="G$1" pin="GPIO34" pad="GPIO34"/>
<connect gate="G$1" pin="GPIO35" pad="GPIO35"/>
<connect gate="G$1" pin="GPIO36" pad="GPIO36"/>
<connect gate="G$1" pin="GPIO39" pad="GPIO39"/>
<connect gate="G$1" pin="GPIO4" pad="GPIO4"/>
<connect gate="G$1" pin="GPIO5" pad="GPIO5"/>
<connect gate="G$1" pin="GPIO6" pad="GPIO6"/>
<connect gate="G$1" pin="GPIO7" pad="GPIO7"/>
<connect gate="G$1" pin="GPIO8" pad="GPIO8"/>
<connect gate="G$1" pin="GPIO9" pad="GPIO9"/>
<connect gate="G$1" pin="VIN3.3V" pad="VIN3.3V"/>
<connect gate="G$1" pin="VIN5V" pad="VIN5V"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="Headers">
<packages>
<package name="1PIN_HEADER">
<pad name="P$1" x="0" y="0" drill="1.016" diameter="1.778"/>
</package>
</packages>
<symbols>
<symbol name="1PIN_HEADER">
<pin name="P$1" x="0" y="0" length="middle"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="1PIN_HEADER">
<gates>
<gate name="G$1" symbol="1PIN_HEADER" x="0" y="0"/>
</gates>
<devices>
<device name="" package="1PIN_HEADER">
<connects>
<connect gate="G$1" pin="P$1" pad="P$1"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="C1" library="SparkFun-Capacitors" deviceset="100UF-POLAR" device="-RADIAL-2.5MM-25V-20%" value="100uF"/>
<part name="ACCELEROMETER" library="Adafruit" deviceset="ADAFRUIT_ADXL335" device=""/>
<part name="U$1" library="19pinheader" deviceset="19PINHEADER" device=""/>
<part name="U$2" library="19pinheader" deviceset="19PINHEADER" device=""/>
<part name="SENSOR" library="ScrewTerminals" deviceset="2.54MM_3P" device=""/>
<part name="RPM_SENSOR" library="ScrewTerminals" deviceset="2.54MM_3P" device=""/>
<part name="5V_POWER" library="ScrewTerminals" deviceset="2.54MM_2P" device=""/>
<part name="STEPPER_B" library="ScrewTerminals" deviceset="2.54MM_2P" device=""/>
<part name="STEPPER_A" library="ScrewTerminals" deviceset="2.54MM_2P" device=""/>
<part name="STEPPER_CONTROL" library="POLOLU" deviceset="DRV8834" device=""/>
<part name="U$3" library="PerfBoard" deviceset="PERFBOARD_CONVEYOR" device=""/>
<part name="ESP1" library="Espressif" deviceset="ESP32_DEV_KIT" device=""/>
<part name="U$4" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$5" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$6" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$7" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$8" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$9" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$10" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$11" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$12" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$13" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$14" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$15" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$16" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$17" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$18" library="Headers" deviceset="1PIN_HEADER" device=""/>
<part name="U$19" library="Headers" deviceset="1PIN_HEADER" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="C1" gate="G$1" x="124.46" y="5.08"/>
<instance part="ACCELEROMETER" gate="G$1" x="99.06" y="-58.42"/>
<instance part="U$1" gate="G$1" x="50.8" y="0"/>
<instance part="U$2" gate="G$1" x="-17.78" y="-91.44" rot="R180"/>
<instance part="SENSOR" gate="G$1" x="154.94" y="-83.82"/>
<instance part="RPM_SENSOR" gate="G$1" x="154.94" y="-60.96"/>
<instance part="5V_POWER" gate="G$1" x="154.94" y="2.54"/>
<instance part="STEPPER_B" gate="G$1" x="154.94" y="-20.32"/>
<instance part="STEPPER_A" gate="G$1" x="154.94" y="-40.64"/>
<instance part="STEPPER_CONTROL" gate="G$1" x="86.36" y="5.08"/>
<instance part="U$3" gate="G$1" x="55.88" y="-116.84"/>
<instance part="ESP1" gate="G$1" x="0" y="0"/>
<instance part="U$4" gate="G$1" x="75.565" y="5.08" rot="R180"/>
<instance part="U$5" gate="G$1" x="75.565" y="0" rot="R180"/>
<instance part="U$6" gate="G$1" x="75.565" y="-5.08" rot="R180"/>
<instance part="U$7" gate="G$1" x="75.565" y="-10.16" rot="R180"/>
<instance part="U$8" gate="G$1" x="75.565" y="-15.24" rot="R180"/>
<instance part="U$9" gate="G$1" x="75.565" y="-20.32" rot="R180"/>
<instance part="U$10" gate="G$1" x="75.565" y="-25.4" rot="R180"/>
<instance part="U$11" gate="G$1" x="75.565" y="-30.48" rot="R180"/>
<instance part="U$12" gate="G$1" x="123.19" y="-30.48"/>
<instance part="U$13" gate="G$1" x="123.19" y="-25.4"/>
<instance part="U$14" gate="G$1" x="123.19" y="-20.32"/>
<instance part="U$15" gate="G$1" x="123.19" y="-15.24"/>
<instance part="U$16" gate="G$1" x="123.19" y="-10.16"/>
<instance part="U$17" gate="G$1" x="123.19" y="-5.08"/>
<instance part="U$18" gate="G$1" x="133.985" y="0"/>
<instance part="U$19" gate="G$1" x="133.985" y="7.62"/>
</instances>
<busses>
</busses>
<nets>
<net name="GND" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$6"/>
<wire x1="-17.78" y1="-66.04" x2="0" y2="-66.04" width="0.1524" layer="91"/>
<label x="-12.7" y="-66.04" size="1.778" layer="95"/>
<pinref part="ESP1" gate="G$1" pin="GND@1"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$1"/>
<wire x1="33.02" y1="0" x2="50.8" y2="0" width="0.1524" layer="91"/>
<label x="40.64" y="0" size="1.778" layer="95"/>
<pinref part="ESP1" gate="G$1" pin="GND@2"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$7"/>
<wire x1="33.02" y1="-30.48" x2="50.8" y2="-30.48" width="0.1524" layer="91"/>
<label x="40.64" y="-30.48" size="1.778" layer="95"/>
<pinref part="ESP1" gate="G$1" pin="GND@3"/>
</segment>
<segment>
<pinref part="ACCELEROMETER" gate="G$1" pin="GND"/>
<wire x1="99.06" y1="-68.58" x2="91.44" y2="-68.58" width="0.1524" layer="91"/>
<label x="91.44" y="-68.58" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="RPM_SENSOR" gate="G$1" pin="P$2"/>
<wire x1="154.94" y1="-63.5" x2="142.24" y2="-63.5" width="0.1524" layer="91"/>
<label x="142.24" y="-63.5" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="SENSOR" gate="G$1" pin="P$2"/>
<wire x1="154.94" y1="-86.36" x2="142.24" y2="-86.36" width="0.1524" layer="91"/>
<label x="142.24" y="-86.36" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="5V_POWER" gate="G$1" pin="P$1"/>
<wire x1="154.94" y1="2.54" x2="144.78" y2="2.54" width="0.1524" layer="91"/>
<label x="144.78" y="2.54" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="C1" gate="G$1" pin="-"/>
<wire x1="124.46" y1="0" x2="133.985" y2="0" width="0.1524" layer="91"/>
<label x="127.635" y="-1.905" size="1.778" layer="95"/>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="GND@1"/>
<wire x1="116.84" y1="0" x2="124.46" y2="0" width="0.1524" layer="91"/>
<junction x="124.46" y="0"/>
<pinref part="U$18" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="GND@2"/>
<wire x1="116.84" y1="-30.48" x2="123.19" y2="-30.48" width="0.1524" layer="91"/>
<label x="118.11" y="-32.385" size="1.778" layer="95"/>
<pinref part="U$12" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="U$3" gate="G$1" pin="P$96"/>
<pinref part="U$3" gate="G$1" pin="P$95"/>
<wire x1="-30.48" y1="-154.94" x2="-30.48" y2="-152.4" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$94"/>
<wire x1="-30.48" y1="-152.4" x2="-30.48" y2="-149.86" width="0.1524" layer="91"/>
<junction x="-30.48" y="-152.4"/>
<pinref part="U$3" gate="G$1" pin="P$93"/>
<wire x1="-30.48" y1="-149.86" x2="-30.48" y2="-147.32" width="0.1524" layer="91"/>
<junction x="-30.48" y="-149.86"/>
<pinref part="U$3" gate="G$1" pin="P$92"/>
<wire x1="-30.48" y1="-147.32" x2="-30.48" y2="-144.78" width="0.1524" layer="91"/>
<junction x="-30.48" y="-147.32"/>
<pinref part="U$3" gate="G$1" pin="P$91"/>
<wire x1="-30.48" y1="-144.78" x2="-30.48" y2="-142.24" width="0.1524" layer="91"/>
<junction x="-30.48" y="-144.78"/>
<pinref part="U$3" gate="G$1" pin="P$90"/>
<wire x1="-30.48" y1="-142.24" x2="-30.48" y2="-139.7" width="0.1524" layer="91"/>
<junction x="-30.48" y="-142.24"/>
<pinref part="U$3" gate="G$1" pin="P$89"/>
<wire x1="-30.48" y1="-139.7" x2="-30.48" y2="-137.16" width="0.1524" layer="91"/>
<junction x="-30.48" y="-139.7"/>
<pinref part="U$3" gate="G$1" pin="P$88"/>
<wire x1="-30.48" y1="-137.16" x2="-30.48" y2="-134.62" width="0.1524" layer="91"/>
<junction x="-30.48" y="-137.16"/>
<pinref part="U$3" gate="G$1" pin="P$87"/>
<wire x1="-30.48" y1="-134.62" x2="-30.48" y2="-132.08" width="0.1524" layer="91"/>
<junction x="-30.48" y="-134.62"/>
<pinref part="U$3" gate="G$1" pin="P$86"/>
<wire x1="-30.48" y1="-132.08" x2="-30.48" y2="-129.54" width="0.1524" layer="91"/>
<junction x="-30.48" y="-132.08"/>
<pinref part="U$3" gate="G$1" pin="P$85"/>
<wire x1="-30.48" y1="-129.54" x2="-30.48" y2="-127" width="0.1524" layer="91"/>
<junction x="-30.48" y="-129.54"/>
<pinref part="U$3" gate="G$1" pin="P$84"/>
<wire x1="-30.48" y1="-127" x2="-30.48" y2="-124.46" width="0.1524" layer="91"/>
<junction x="-30.48" y="-127"/>
<pinref part="U$3" gate="G$1" pin="P$83"/>
<wire x1="-30.48" y1="-124.46" x2="-30.48" y2="-121.92" width="0.1524" layer="91"/>
<junction x="-30.48" y="-124.46"/>
<pinref part="U$3" gate="G$1" pin="P$82"/>
<wire x1="-30.48" y1="-121.92" x2="-30.48" y2="-119.38" width="0.1524" layer="91"/>
<junction x="-30.48" y="-121.92"/>
<pinref part="U$3" gate="G$1" pin="P$81"/>
<wire x1="-30.48" y1="-119.38" x2="-30.48" y2="-116.84" width="0.1524" layer="91"/>
<junction x="-30.48" y="-119.38"/>
<wire x1="-30.48" y1="-116.84" x2="-30.48" y2="-109.22" width="0.1524" layer="91"/>
<junction x="-30.48" y="-116.84"/>
<label x="-30.48" y="-109.22" size="1.778" layer="95"/>
</segment>
</net>
<net name="EN" class="0">
<segment>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="ENABLE"/>
<wire x1="86.36" y1="5.08" x2="75.565" y2="5.08" width="0.1524" layer="91"/>
<label x="75.565" y="5.08" size="1.778" layer="95"/>
<pinref part="U$4" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="ESP1" gate="G$1" pin="GPIO17"/>
<pinref part="U$1" gate="G$1" pin="P$11"/>
<wire x1="33.02" y1="-50.8" x2="50.8" y2="-50.8" width="0.1524" layer="91"/>
<label x="40.64" y="-50.8" size="1.778" layer="95"/>
</segment>
</net>
<net name="STEP" class="0">
<segment>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="STEP"/>
<wire x1="86.36" y1="-25.4" x2="75.565" y2="-25.4" width="0.1524" layer="91"/>
<label x="76.835" y="-25.4" size="1.778" layer="95"/>
<pinref part="U$10" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$12"/>
<wire x1="50.8" y1="-55.88" x2="33.02" y2="-55.88" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO16"/>
<label x="40.64" y="-55.88" size="1.778" layer="95"/>
</segment>
</net>
<net name="DIR" class="0">
<segment>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="DIR"/>
<wire x1="86.36" y1="-30.48" x2="75.565" y2="-30.48" width="0.1524" layer="91"/>
<label x="76.835" y="-30.48" size="1.778" layer="95"/>
<pinref part="U$11" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$16"/>
<wire x1="33.02" y1="-76.2" x2="50.8" y2="-76.2" width="0.1524" layer="91"/>
<label x="40.64" y="-76.2" size="1.778" layer="95"/>
<pinref part="ESP1" gate="G$1" pin="GPIO15"/>
</segment>
</net>
<net name="B2" class="0">
<segment>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="B2"/>
<wire x1="116.84" y1="-5.08" x2="123.19" y2="-5.08" width="0.1524" layer="91"/>
<label x="118.745" y="-5.08" size="1.778" layer="95"/>
<pinref part="U$17" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="STEPPER_B" gate="G$1" pin="P$2"/>
<wire x1="154.94" y1="-22.86" x2="142.24" y2="-22.86" width="0.1524" layer="91"/>
<label x="142.24" y="-22.86" size="1.778" layer="95"/>
</segment>
</net>
<net name="B1" class="0">
<segment>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="B1"/>
<wire x1="116.84" y1="-10.16" x2="123.19" y2="-10.16" width="0.1524" layer="91"/>
<label x="118.745" y="-10.16" size="1.778" layer="95"/>
<pinref part="U$16" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="STEPPER_B" gate="G$1" pin="P$1"/>
<wire x1="154.94" y1="-20.32" x2="142.24" y2="-20.32" width="0.1524" layer="91"/>
<label x="142.24" y="-20.32" size="1.778" layer="95"/>
</segment>
</net>
<net name="A1" class="0">
<segment>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="A1"/>
<wire x1="116.84" y1="-15.24" x2="123.19" y2="-15.24" width="0.1524" layer="91"/>
<label x="118.745" y="-15.24" size="1.778" layer="95"/>
<pinref part="U$15" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="STEPPER_A" gate="G$1" pin="P$2"/>
<wire x1="154.94" y1="-43.18" x2="142.24" y2="-43.18" width="0.1524" layer="91"/>
<label x="142.24" y="-43.18" size="1.778" layer="95"/>
</segment>
</net>
<net name="A2" class="0">
<segment>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="A2"/>
<wire x1="116.84" y1="-20.32" x2="123.19" y2="-20.32" width="0.1524" layer="91"/>
<label x="118.745" y="-20.32" size="1.778" layer="95"/>
<pinref part="U$14" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="STEPPER_A" gate="G$1" pin="P$1"/>
<wire x1="154.94" y1="-40.64" x2="142.24" y2="-40.64" width="0.1524" layer="91"/>
<label x="142.24" y="-40.64" size="1.778" layer="95"/>
</segment>
</net>
<net name="Z" class="0">
<segment>
<pinref part="ACCELEROMETER" gate="G$1" pin="ZOUT"/>
<wire x1="99.06" y1="-73.66" x2="91.44" y2="-73.66" width="0.1524" layer="91"/>
<label x="91.44" y="-73.66" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$2" gate="G$1" pin="P$15"/>
<wire x1="0" y1="-20.32" x2="-17.78" y2="-20.32" width="0.1524" layer="91"/>
<label x="-10.16" y="-20.32" size="1.778" layer="95"/>
<pinref part="ESP1" gate="G$1" pin="GPIO34"/>
</segment>
</net>
<net name="Y" class="0">
<segment>
<pinref part="ACCELEROMETER" gate="G$1" pin="YOUT"/>
<wire x1="99.06" y1="-78.74" x2="91.44" y2="-78.74" width="0.1524" layer="91"/>
<label x="91.44" y="-78.74" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$2" gate="G$1" pin="P$14"/>
<wire x1="-17.78" y1="-25.4" x2="0" y2="-25.4" width="0.1524" layer="91"/>
<label x="-10.16" y="-25.4" size="1.778" layer="95"/>
<pinref part="ESP1" gate="G$1" pin="GPIO35"/>
</segment>
</net>
<net name="X" class="0">
<segment>
<pinref part="ACCELEROMETER" gate="G$1" pin="XOUT"/>
<wire x1="99.06" y1="-83.82" x2="91.44" y2="-83.82" width="0.1524" layer="91"/>
<label x="91.44" y="-83.82" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$2" gate="G$1" pin="P$13"/>
<wire x1="0" y1="-30.48" x2="-17.78" y2="-30.48" width="0.1524" layer="91"/>
<label x="-10.16" y="-30.48" size="1.778" layer="95"/>
<pinref part="ESP1" gate="G$1" pin="GPIO32"/>
</segment>
</net>
<net name="+3.3V" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$19"/>
<wire x1="0" y1="0" x2="-17.78" y2="0" width="0.1524" layer="91"/>
<label x="-12.7" y="0" size="1.778" layer="95"/>
<pinref part="ESP1" gate="G$1" pin="VIN3.3V"/>
</segment>
<segment>
<pinref part="ACCELEROMETER" gate="G$1" pin="VIN"/>
<wire x1="99.06" y1="-58.42" x2="91.44" y2="-58.42" width="0.1524" layer="91"/>
<label x="91.44" y="-58.42" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="RPM_SENSOR" gate="G$1" pin="P$1"/>
<wire x1="154.94" y1="-60.96" x2="142.24" y2="-60.96" width="0.1524" layer="91"/>
<label x="142.24" y="-60.96" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="SENSOR" gate="G$1" pin="P$1"/>
<wire x1="154.94" y1="-83.82" x2="142.24" y2="-83.82" width="0.1524" layer="91"/>
<label x="142.24" y="-83.82" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="M1"/>
<wire x1="86.36" y1="-5.08" x2="75.565" y2="-5.08" width="0.1524" layer="91"/>
<label x="78.105" y="-5.08" size="1.778" layer="95"/>
<pinref part="U$6" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="SLEEP"/>
<wire x1="86.36" y1="-20.32" x2="75.565" y2="-20.32" width="0.1524" layer="91"/>
<label x="76.2" y="-20.32" size="1.778" layer="95"/>
<pinref part="U$9" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="U$3" gate="G$1" pin="P$16"/>
<pinref part="U$3" gate="G$1" pin="P$15"/>
<wire x1="55.88" y1="-154.94" x2="55.88" y2="-152.4" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$14"/>
<wire x1="55.88" y1="-152.4" x2="55.88" y2="-149.86" width="0.1524" layer="91"/>
<junction x="55.88" y="-152.4"/>
<pinref part="U$3" gate="G$1" pin="P$13"/>
<wire x1="55.88" y1="-149.86" x2="55.88" y2="-147.32" width="0.1524" layer="91"/>
<junction x="55.88" y="-149.86"/>
<pinref part="U$3" gate="G$1" pin="P$12"/>
<wire x1="55.88" y1="-147.32" x2="55.88" y2="-144.78" width="0.1524" layer="91"/>
<junction x="55.88" y="-147.32"/>
<pinref part="U$3" gate="G$1" pin="P$11"/>
<wire x1="55.88" y1="-144.78" x2="55.88" y2="-142.24" width="0.1524" layer="91"/>
<junction x="55.88" y="-144.78"/>
<pinref part="U$3" gate="G$1" pin="P$10"/>
<wire x1="55.88" y1="-142.24" x2="55.88" y2="-139.7" width="0.1524" layer="91"/>
<junction x="55.88" y="-142.24"/>
<pinref part="U$3" gate="G$1" pin="P$9"/>
<wire x1="55.88" y1="-139.7" x2="55.88" y2="-137.16" width="0.1524" layer="91"/>
<junction x="55.88" y="-139.7"/>
<pinref part="U$3" gate="G$1" pin="P$8"/>
<wire x1="55.88" y1="-137.16" x2="55.88" y2="-134.62" width="0.1524" layer="91"/>
<junction x="55.88" y="-137.16"/>
<pinref part="U$3" gate="G$1" pin="P$7"/>
<wire x1="55.88" y1="-134.62" x2="55.88" y2="-132.08" width="0.1524" layer="91"/>
<junction x="55.88" y="-134.62"/>
<pinref part="U$3" gate="G$1" pin="P$6"/>
<wire x1="55.88" y1="-132.08" x2="55.88" y2="-129.54" width="0.1524" layer="91"/>
<junction x="55.88" y="-132.08"/>
<pinref part="U$3" gate="G$1" pin="P$5"/>
<wire x1="55.88" y1="-129.54" x2="55.88" y2="-127" width="0.1524" layer="91"/>
<junction x="55.88" y="-129.54"/>
<pinref part="U$3" gate="G$1" pin="P$4"/>
<wire x1="55.88" y1="-127" x2="55.88" y2="-124.46" width="0.1524" layer="91"/>
<junction x="55.88" y="-127"/>
<pinref part="U$3" gate="G$1" pin="P$3"/>
<wire x1="55.88" y1="-124.46" x2="55.88" y2="-121.92" width="0.1524" layer="91"/>
<junction x="55.88" y="-124.46"/>
<pinref part="U$3" gate="G$1" pin="P$2"/>
<wire x1="55.88" y1="-121.92" x2="55.88" y2="-119.38" width="0.1524" layer="91"/>
<junction x="55.88" y="-121.92"/>
<pinref part="U$3" gate="G$1" pin="P$1"/>
<wire x1="55.88" y1="-119.38" x2="55.88" y2="-116.84" width="0.1524" layer="91"/>
<junction x="55.88" y="-119.38"/>
<wire x1="55.88" y1="-116.84" x2="55.88" y2="-109.22" width="0.1524" layer="91"/>
<junction x="55.88" y="-116.84"/>
<label x="55.88" y="-109.22" size="1.778" layer="95"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$2"/>
<wire x1="-17.78" y1="-86.36" x2="0" y2="-86.36" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO11"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$3"/>
<wire x1="-17.78" y1="-81.28" x2="0" y2="-81.28" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO10"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$4"/>
<wire x1="-17.78" y1="-76.2" x2="0" y2="-76.2" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO9"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$5"/>
<wire x1="-17.78" y1="-71.12" x2="0" y2="-71.12" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO13"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$7"/>
<wire x1="-17.78" y1="-60.96" x2="0" y2="-60.96" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO12"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$9"/>
<wire x1="-17.78" y1="-50.8" x2="0" y2="-50.8" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO27"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$10"/>
<wire x1="0" y1="-45.72" x2="-17.78" y2="-45.72" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO26"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$11"/>
<wire x1="-17.78" y1="-40.64" x2="0" y2="-40.64" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO25"/>
</segment>
</net>
<net name="N$15" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$18"/>
<wire x1="0" y1="-5.08" x2="-17.78" y2="-5.08" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="EN"/>
</segment>
</net>
<net name="N$16" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="P$2"/>
<wire x1="33.02" y1="-5.08" x2="50.8" y2="-5.08" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO23"/>
</segment>
</net>
<net name="N$17" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="P$3"/>
<wire x1="33.02" y1="-10.16" x2="50.8" y2="-10.16" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO22"/>
</segment>
</net>
<net name="N$18" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="P$4"/>
<wire x1="33.02" y1="-15.24" x2="50.8" y2="-15.24" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO1"/>
</segment>
</net>
<net name="N$19" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="P$5"/>
<wire x1="33.02" y1="-20.32" x2="50.8" y2="-20.32" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO3"/>
</segment>
</net>
<net name="RPM" class="0">
<segment>
<pinref part="RPM_SENSOR" gate="G$1" pin="P$3"/>
<wire x1="154.94" y1="-66.04" x2="142.24" y2="-66.04" width="0.1524" layer="91"/>
<label x="142.24" y="-66.04" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$2" gate="G$1" pin="P$12"/>
<wire x1="0" y1="-35.56" x2="-17.78" y2="-35.56" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO33"/>
<label x="-12.7" y="-35.56" size="1.778" layer="95"/>
</segment>
</net>
<net name="N$23" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="P$10"/>
<wire x1="33.02" y1="-45.72" x2="50.8" y2="-45.72" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO5"/>
</segment>
</net>
<net name="N$26" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="P$13"/>
<wire x1="50.8" y1="-60.96" x2="33.02" y2="-60.96" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO4"/>
</segment>
</net>
<net name="N$27" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="P$14"/>
<wire x1="50.8" y1="-66.04" x2="33.02" y2="-66.04" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO0"/>
</segment>
</net>
<net name="N$28" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="P$15"/>
<wire x1="33.02" y1="-71.12" x2="50.8" y2="-71.12" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO2"/>
</segment>
</net>
<net name="N$29" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="P$17"/>
<wire x1="33.02" y1="-81.28" x2="50.8" y2="-81.28" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO8"/>
</segment>
</net>
<net name="N$30" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="P$18"/>
<wire x1="33.02" y1="-86.36" x2="50.8" y2="-86.36" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO7"/>
</segment>
</net>
<net name="N$31" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="P$19"/>
<wire x1="33.02" y1="-91.44" x2="50.8" y2="-91.44" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO6"/>
</segment>
</net>
<net name="SENSOR" class="0">
<segment>
<pinref part="SENSOR" gate="G$1" pin="P$3"/>
<wire x1="154.94" y1="-88.9" x2="142.24" y2="-88.9" width="0.1524" layer="91"/>
<label x="142.24" y="-88.9" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$6"/>
<wire x1="33.02" y1="-25.4" x2="50.8" y2="-25.4" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO21"/>
<label x="38.1" y="-25.4" size="1.778" layer="95"/>
</segment>
</net>
<net name="+5V" class="0">
<segment>
<pinref part="5V_POWER" gate="G$1" pin="P$2"/>
<wire x1="154.94" y1="0" x2="144.78" y2="0" width="0.1524" layer="91"/>
<label x="144.78" y="0" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="C1" gate="G$1" pin="+"/>
<wire x1="124.46" y1="7.62" x2="133.985" y2="7.62" width="0.1524" layer="91"/>
<label x="128.905" y="7.62" size="1.778" layer="95"/>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="VMOT"/>
<wire x1="116.84" y1="5.08" x2="116.84" y2="7.62" width="0.1524" layer="91"/>
<wire x1="116.84" y1="7.62" x2="124.46" y2="7.62" width="0.1524" layer="91"/>
<junction x="124.46" y="7.62"/>
<pinref part="U$19" gate="G$1" pin="P$1"/>
</segment>
<segment>
<pinref part="U$2" gate="G$1" pin="P$1"/>
<wire x1="-17.78" y1="-91.44" x2="0" y2="-91.44" width="0.1524" layer="91"/>
<label x="-12.7" y="-91.44" size="1.778" layer="95"/>
<pinref part="ESP1" gate="G$1" pin="VIN5V"/>
</segment>
</net>
<net name="P$8" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$8"/>
<wire x1="-17.78" y1="-55.88" x2="0" y2="-55.88" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO14"/>
</segment>
</net>
<net name="P$16" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$16"/>
<wire x1="-17.78" y1="-15.24" x2="0" y2="-15.24" width="0.1524" layer="91"/>
<pinref part="ESP1" gate="G$1" pin="GPIO39"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="U$5" gate="G$1" pin="P$1"/>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="M0"/>
<wire x1="75.565" y1="0" x2="86.36" y2="0" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="U$7" gate="G$1" pin="P$1"/>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="CONFIG"/>
<wire x1="75.565" y1="-10.16" x2="86.36" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="U$8" gate="G$1" pin="P$1"/>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="VREF"/>
<wire x1="75.565" y1="-15.24" x2="86.36" y2="-15.24" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$14" class="0">
<segment>
<pinref part="STEPPER_CONTROL" gate="G$1" pin="FAULT"/>
<pinref part="U$13" gate="G$1" pin="P$1"/>
<wire x1="116.84" y1="-25.4" x2="123.19" y2="-25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$20" class="0">
<segment>
<pinref part="ESP1" gate="G$1" pin="GPIO19"/>
<pinref part="U$1" gate="G$1" pin="P$8"/>
<wire x1="33.02" y1="-35.56" x2="50.8" y2="-35.56" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$21" class="0">
<segment>
<pinref part="ESP1" gate="G$1" pin="GPIO18"/>
<pinref part="U$1" gate="G$1" pin="P$9"/>
<wire x1="33.02" y1="-40.64" x2="50.8" y2="-40.64" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$22" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$17"/>
<pinref part="ESP1" gate="G$1" pin="GPIO36"/>
<wire x1="-17.78" y1="-10.16" x2="0" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
