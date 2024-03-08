// -------------------------------------------------------
//
// "NEVATO" theme for Attract-Mode Front-End
// version 1.0
// 
// graphic design and coding = www.ClanLogoDesign.com
// cabinet design and photo = www.tenDESIGN.pro
//
// read more at www.ONYXarcade.com/nevato
//
// spinwheel code forked from omegaman's "ROBOSPIN" theme
//
// -------------------------------------------------------
//
// this theme is free for private use only
// and can be distributed only with Attract Mode front-end
// for other uses please contact ONYXarcade.com for permission
//
// -------------------------------------------------------
//
// special thanks to omegaman for ROBOSPIN theme
// without it - we wouldn't be able to learn how
// to code AM themes
//
// -------------------------------------------------------


class UserConfig {

</ label="NEVATO theme", help=" ", options=" ", order=1 /> divider1="";
</ label="- - -", help=" ", options=" ", order=1 /> divider1="";
//-----------------------------------------------------------------
</ label="mute videos snaps sound", help="yes = sound disabled, no = sound enabled", options="yes,no", order=2 /> mute_videoSnaps="no";

</ label="- - -", help=" ", options=" ", order=3 /> divider2="";
//-----------------------------------------------------------------
</ label="cab screen", help="video = video snap, screenshot = game screenshot", options="video, screenshot", order=4 /> cabScreenType="video";
</ label="scanlines on screen", help="show scanlines effect on cab screen.", options="light,medium,dark,off", order=5 /> enable_scanlines="light";

</ label="- - -", help=" ", options=" ", order=6 /> divider3="";
//-----------------------------------------------------------------
</ label="marquee artwork", help="marquee type, replace ''my-own-marquee.jpg'' file with your own", options="marquee,emulator-name,my-own", order=7 /> marquee_type="marquee"; 
 
</ label="- - -", help=" ", options=" ", order=9 /> divider4="";
//-----------------------------------------------------------------
</ label="LCD right side", help="what's on right side of LCD", options="filter, emulator, display-name, rom-filename, off,", order=10 /> lcdRight="filter"; 

</ label="- - -", help=" ", options=" ", order=11 /> divider5="";
//-----------------------------------------------------------------
</ label="spinwheel artwork", help="marquee or wheel", options="marquee,wheel", order=12 /> spinwheelArt="wheel";
</ label="speenwheel transition time", help="Time in milliseconds for wheel spin.", order=13 /> transition_ms="80";
   
</ label="- - -", help=" ", options=" ", order=14 /> divider6="";
//-----------------------------------------------------------------
</ label="background art", help="Display the flyer/fanart/snap(screenshot)/video in background.", options="flyer,fanart,snap,video,none", order=15 /> enable_bg_art="fanart";
</ label="background ststic image", help="background image if there is no background art", options="blue,black,none", order=16 /> enable_static_bkg="black";
</ label="background mask", help="make background medium or dark", options="dark,medium", order=17 /> enable_mask="dark";

</ label="- - -", help=" ", options=" ", order=18 /> divider7="";
//-----------------------------------------------------------------
}  


local my_config = fe.get_config();


fe.load_module( "fade" );

local blip = fe.layout.height;
local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;


//fe.layout.width = 1920;
//fe.layout.height = 1080;






//coordinates table for different screen aspects -------------------------- START



local settings = {
   "default": {
      aspectDepend = { 
        snap_skewX = 42.0, 
        snap_skewY = -8.0, 

        snap_pinchX = 0, 
        snap_pinchY = 29.0, 
        snap_rotation = 0.9, 

        marquee_skewX = 17, 
        marquee_skewY = 0, 
        marquee_pinchX = -2, 
        marquee_pinchY = 7, 
        marquee_rotation = 6.2, 

        wheelNumElements = 10 }
   },
   "16x10": {
      aspectDepend = { 
        res_x = 1920,
        res_y = 1200,

        maskFactor = 1.9,

        snap_skewX = 62.5, 
        snap_skewY = -12.9, 
        snap_pinchX = 0, 
        snap_pinchY = 40.0, 
        snap_rotation = 1.0, 

        wheelNumElements = 10 }
   },
    "16x9": {
      aspectDepend = { 
        res_x = 2133,
        res_y = 1200,

        maskFactor = 1.9,

        snap_skewX = 62.5, 
        snap_skewY = -12.9, 
        snap_pinchX = 0, 
        snap_pinchY = 40.0, 
        snap_rotation = 1.0, 

        wheelNumElements = 6 }
   },
   "4x3": {
      aspectDepend = { 
        res_x = 1600,
        res_y = 1200,

        maskFactor = 1.6,

        snap_skewX = 62.5, 
        snap_skewY = -12.9, 
        snap_pinchX = 0, 
        snap_pinchY = 40.0, 
        snap_rotation = 1.0, 

        wheelNumElements = 10 }
   }
   "5x4": {
      aspectDepend = { 
        res_x = 1500,
        res_y = 1200,

        maskFactor = 1.6,

        snap_skewX = 62.5, 
        snap_skewY = -12.9, 
        snap_pinchX = 0, 
        snap_pinchY = 40.0, 
        snap_rotation = 1.0, 

        wheelNumElements = 10 }
   }
}




local aspect = fe.layout.width / fe.layout.height.tofloat();
print (aspect);
local aspect_name = "";
switch( aspect.tostring() )
{
    case "1.77865":  //for 1366x768 screen
    case "1.77778":  //for any other 16x9 resolution
        aspect_name = "16x9";
        break;
    case "1.6":
        aspect_name = "16x10";
        break;
    case "1.33333":
        aspect_name = "4x3";
        break;
    case "1.25":
        aspect_name = "5x4";
        break;
    case "0.75":
        aspect_name = "3x4";
        break;
    default:
		aspect_name = "16x9";
}


function Setting( id, name )
{
    if ( aspect_name in settings && id in settings[aspect_name] && name in settings[aspect_name][id] )
  {
    ::print("\tusing settings[" + aspect_name + "][" + id + "][" + name + "] : " + settings[aspect_name][id][name] + "\n" );
    return settings[aspect_name][id][name];
  } else if ( aspect_name in settings == false )
  {
    ::print("\tsettings[" + aspect_name + "] does not exist\n");
  } else if ( name in settings[aspect_name][id] == false )
  {
    ::print("\tsettings[" + aspect_name + "][" + id + "][" + name + "] does not exist\n");
  }
  ::print("\t\tusing default value: " + settings["default"][id][name] + "\n" );
  return settings["default"][id][name];
}




fe.layout.width = Setting("aspectDepend", "res_x");
fe.layout.height = Setting("aspectDepend", "res_y");

local blip = fe.layout.height;

local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;

local mask_factor = Setting("aspectDepend", "maskFactor");


//coordinates table for different screen aspects -------------------------- END









// mute audio variable - definable via user config ------------------------ START

if ( my_config["mute_videoSnaps"] == "yes") 
{
::videoSound <- Vid.NoAudio;
}
if ( my_config["mute_videoSnaps"] == "no") 
{
::videoSound <- Vid.Default;
}

// mute audio variable - definable via user config ------------------------ END







// default background image (if background art is not enabled) ------------- START

if ( my_config["enable_static_bkg"] == "blue") 
{
 local bg = fe.add_image( "background_blue.png", 0, 0, flw, flh );
}
if ( my_config["enable_static_bkg"] == "black")
{
 local bg = fe.add_image( "background_black.png", 0, 0, flw, flh );
}
if ( my_config["enable_static_bkg"] == "none") 
{
 local bg = fe.add_image( "", 0, 0, flw, flh );
}

// default background image (if background art is not enabled) ------------- END







// background art --------------------------------------------------------- START

if ( my_config["enable_bg_art"] == "flyer") 
{
 local bgart = fe.add_artwork( "flyer", flw*0.2, flw*0, flw*0.6, 0);
 bgart.preserve_aspect_ratio = true;
 local mask = fe.add_image( "mask_edges.png", 0 , 0, mask_factor*flh, flh );  //gradient to mask left and right edge of the flyer 1.6 for 4:3 and 16:10  1.9 for 16:9
 mask.preserve_aspect_ratio = false;
}



if ( my_config["enable_bg_art"] == "fanart") 
{
 local bgart = FadeArt( "fanart", 0, 0, 0, flh);
 bgart.preserve_aspect_ratio = true;
 local mask = fe.add_image( "mask_edges.png", 0 , 0, mask_factor*flh, flh );  //gradient to mask left and right edge of the flyer
 mask.preserve_aspect_ratio = false;
 //mask.alpha = 255;
}



if ( my_config["enable_bg_art"] == "snap") 
{
 local bgart = fe.add_artwork( "snap", flx-flh*1.34, 0, flh*1.34, 0);
 bgart.preserve_aspect_ratio = true;
 bgart.video_flags=Vid.ImagesOnly;
}



if ( my_config["enable_bg_art"] == "video") 
{
 local bgart = fe.add_artwork( "snap", flx-flh*1.34, 0, flh*1.34, 0);
 bgart.preserve_aspect_ratio = true;
 bgart.video_flags = videoSound;
}


// background art --------------------------------------------------------- END






//masking background (adding scanlines and vignette) -------------------- START

if ( my_config["enable_mask"] == "none" )
{
local masking = fe.add_image( "", 0, 0, flw, 0 );
}


if ( my_config["enable_mask"] == "medium" )
{
local masking = fe.add_image( "background_mask.png", 0, 0, flx, fly );
masking.preserve_aspect_ratio = false;
masking.alpha = 150;           // here you can change mask opacity light=100, medium=150, dark (default)=255
local maskingMedium = fe.add_image( "background_mask_medium.png", 0, 0, flx, fly );
maskingMedium.preserve_aspect_ratio = false;
}


if ( my_config["enable_mask"] == "dark" )
{
local masking = fe.add_image( "background_mask.png", 0, 0, flx,fly);   //for 4:3 fix 1.6*fly
masking.preserve_aspect_ratio = false;
masking.alpha = 255;           // here you can change mask opacity light=100, medium=150, dark (default)=255
}

//masking background (adding scanlines and vignette) -------------------- END




// SpinWheel -------------------------- START - this part is slightly modified code from omegaman's ROBOSPIN theme

 
fe.load_module( "conveyor" );
local wheel_x = [ flx*0.87, flx*0.79, flx*0.765, flx*0.745, flx*0.73, flx*0.72, flx*0.67, flx*0.72, flx*0.73, flx*0.745, flx*0.765, flx*0.79, ]; 
local wheel_y = [ -fly*0.22, -fly*0.105, fly*0.0, fly*0.105, fly*0.215, fly*0.325, fly*0.436, fly*0.61, fly*0.72 fly*0.83, fly*0.935, fly*0.99, ];
local wheel_w = [ flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.28, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, ];
local wheel_a = [  80,  80,  80,  80,  80,  80, 255,  80,  80,  80,  80,  80, ];
local wheel_h = [  flw*0.07,  flw*0.07,  flw*0.07,  flw*0.08,  flw*0.08,  flw*0.08, flw*0.11,  flw*0.07,  flw*0.07,  flw*0.07,  flw*0.07,  flw*0.07, ];
//local wheel_r = [  31,  26,  21,  16,  11,   6,   0, -11, -16, -21, -26, -31, ];
local wheel_r = [  30,  25,  20,  15,  10,   5,   0, -10, -15, -20, -25, -30, ];
local num_arts = Setting("aspectDepend", "wheelNumElements");  // number of elements in wheel - depending on screen aspect ratio




class WheelEntry extends ConveyorSlot
{
	constructor()
	{
		base.constructor( ::fe.add_artwork( my_config["spinwheelArt"] ) );
    preserve_aspect_ratio = true;
    video_flags=Vid.ImagesOnly; // added just in case if you have video marquees - like I do :)
	}

	function on_progress( progress, var )
	{
		local p = progress / 0.1;
		local slot = p.tointeger();
		p -= slot;
		
		slot++;

		if ( slot < 0 ) slot=0;
		if ( slot >=10 ) slot=10;

		m_obj.x = wheel_x[slot] + p * ( wheel_x[slot+1] - wheel_x[slot] );
		m_obj.y = wheel_y[slot] + p * ( wheel_y[slot+1] - wheel_y[slot] );
		m_obj.width = wheel_w[slot] + p * ( wheel_w[slot+1] - wheel_w[slot] );
		m_obj.height = wheel_h[slot] + p * ( wheel_h[slot+1] - wheel_h[slot] );
		m_obj.rotation = wheel_r[slot] + p * ( wheel_r[slot+1] - wheel_r[slot] );
		m_obj.alpha = wheel_a[slot] + p * ( wheel_a[slot+1] - wheel_a[slot] );
	}
};

local wheel_entries = [];
for ( local i=0; i<num_arts/2; i++ )
	wheel_entries.push( WheelEntry() );

local remaining = num_arts - wheel_entries.len();

// we do it this way so that the last wheelentry created is the middle one showing the current
// selection (putting it at the top of the draw order)

for ( local i=0; i<remaining; i++ )
	wheel_entries.insert( num_arts/2, WheelEntry() );

local conveyor = Conveyor();
conveyor.set_slots( wheel_entries );
conveyor.transition_ms = 50;
try { conveyor.transition_ms = my_config["transition_ms"].tointeger(); } catch ( e ) { }
