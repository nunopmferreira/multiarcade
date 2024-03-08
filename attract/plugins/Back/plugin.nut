///////////////////////////////////////////////////
//
// Attract-Mode Frontend - ReturnOption plugin
//
///////////////////////////////////////////////////
//
// Define use configurable settings
//
class UserConfig </ help="This plugin will allow to add return option in romlist files" /> {

	</ label="Generate Return", help="Generate the return entries in Romlist files", is_function=true, order=5 />
	// Map the config option to the "generate_index" function in "file_util.nut"
	generate="generate_back";

}

//
// Load our file utilities
//
local my_dir = fe.script_dir;
dofile( my_dir + "file_util.nut" );

local back_filter="displays_menu|Displays Menu"

local romlist_file= {};
romlist_file["Mame"] <-"/home/nunoferreira/.attract/romlists/mame.txt";
romlist_file["VisualPinball"] <-"/home/nunoferreira/.attract/romlists/VisualPinball.txt";

class FilterMenu {

	_trigger="custom1";
	_my_config=null;

	constructor() {
		fe.add_transition_callback(this, "transitions");
		fe.add_signal_handler( this, "on_signal" );
		
		_my_config=fe.get_config();
		_trigger=_my_config["trigger"].tolower();
		
		//addFilters();
	}

	function test(config){
		print("\nEntering Config");
	}
	
	function transitions(ttype, var, ttime) {
		print("\nEntering Transition with ttype: "+ttype);
		switch (ttype) {
			case 0: //0
				print("\nTransition.StartLayout");
				break;
			case 1: //1
				print("\nTransition.EndLayout");
				break;
			case 2: //2
				print("\nTransition.ToNewSelection");
				break;
			case Transition.FromOldSelection: //3
				print("\nTransition.FromOldSelection");
				break;
			case Transition.ToGame: //4
				print("\nTransition.ToGame");
				break;
			case Transition.FromGame: //5
				print("\nTransition.FromGame");
				break;
			case Transition.ToNewList: //6
				print("\nTransition.ToNewList");
				break;
			case Transition.EndNavigation: //7
				print("\nTransition.EndNavigation");
				break;
			case 8: //8
				print("\nTransition.EnteringFilterMenuShowOverlay");
				break;
			case 9: //9
				print("\nTransition.ExitingFilterMenuHideOverlay");
				break;
			case 10: //10
				print("\nTransition.BetweenFiltersNewSelOverlay");
				break;
			case 11: //11
				print("\nTransition.ChangedTag");
				break;
		}		   
   
		print("\nPrint Current Display is: "+fe.list.name);
		print("\nPrint Current Display: "+fe.displays[fe.list.display_index].name);
		print("\nPrint Using romlist: "+fe.displays[fe.list.display_index].romlist);
		print("\nPrint fe.list.display_index: "+fe.list.display_index);
		print("\nPrint Layout has num filters: "+fe.filters.len());
//		print("\nPrint Filter is:"+fe.filters[fe.list.filter_index].name);
//		print("\nPrint fe.list.filter_index: "+fe.list.filter_index);
//		print("\nPrint Number of games is: "+fe.list.size);
//		print("\nPrint Current Game is: "+fe.game_info(Info.Name,0));

        foreach ( display in fe.displays )
        {
            print("\nPrint Loop Display is: "+display.name);
            print("\nPrint Loop romlist: "+display.romlist);
        }


		local splited_filter=split(back_filter,"|");

		switch (ttype) {
				
			case Transition.ToGame: //4
			//	print("\nEntered Transition.ToGame");
			
			//	print("\nAnalysing if rom is Displays Menu:"+fe.game_info(Info.Name,0).slice(0,3));				
							
				if (fe.game_info(Info.Name,0) == splited_filter[0]){
				
				//	print("\nPrint Returning to Previous Menu");
					fe.signal("displays_menu");
					return false;			
				}
				
		}			
				

		return false;
	}
	
	function on_signal(signal){
		print("\nReceived Signal: "+signal);		
		if ( signal == _trigger ){
			print("\nReceived Filter Generation Trigger!!");
			generate_filters();
		}	
		return false;
	}
	
	function generate_filters(){
	
		local config=fe.get_config();
		print("\nPrint Generating Filters on Display/Emulator is: "+fe.displays[fe.list.display_index].name+" We have num filters: "+fe.filters.len());
		//Will do this only for current display and if it's not <=0 
		if 	( fe.list.display_index < 0) {
			//display is Displays Menu will not do anything
			return false;
		}	
		
		//Back Filter is added by default to return to previous menu
		//addFilter(back_filter);
			
		//Will not use filters, only menus so I'm commenting the lines below	
		//Add the remaing configured filters
		//for ( local i=0; i<fe.filters.len(); i++ ){
		//	addFilter(fe.filters[i].name);
		//}
		return true;
	}

	function addFilter(filter_string){
		print("\nAdding Filter:"+filter_string);
		local splited_filter=split(filter_string,"|");
		if ( splited_filter.len() != 2 ){
			return false;
		}
		local filter_name=splited_filter[0];
		local filter_title=splited_filter[1];
	
		print("\nTrying to add Filter:"+filter_name);	
		//For each Game in list	
		local found=false;
		for ( local i=0; i<fe.list.size; i++ ){
			print("\nAnalysing Game:"+ fe.game_info(Info.Name,i));
			if ( fe.game_info(Info.Name,i) == filter_name ){
				// found match
				found=true;
				//TODO correct filter Title if not correct
				//if ( fe.game_info(Info.Title,i) != filter_title ){
				//}
				break;
			}
		}
		if (!found){
			//Didn't find filter in Game list, add it in Game list
			print("\nWill add Filter:"+filter_name);
			
			//fe.signal("insert_game");
			//fe.signal("displays_menu");
			// create a dummy rom file in rom folder
			local cur_romlist=romlist_file[fe.displays[fe.list.display_index].name];
			local filter_config=filter_name+";"+filter_title+";"+fe.displays[fe.list.display_index].romlist+";;;;;;;;;;;;;;;;;;";
			print("\nFilterFile:"+filter_name+" "+filter_config+" "+cur_romlist);
			write_ln_to_file(cur_romlist,filter_config);
		}
	}
	
}
fe.plugin["FilterMenu"] <- FilterMenu();
