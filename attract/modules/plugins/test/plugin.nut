// --------------------
// Filter Menu
// --------------------

class FilterMenu {
	constructor() {
		fe.add_transition_callback(this, "transitions");
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
   
		print("\nPrint fe.list.name: "+fe.list.name);
		print("\nPrint fe.list.display_index: "+fe.list.display_index);
		print("\nPrint fe.list.filter_index: "+fe.list.filter_index);
		print("\nPrint fe.list.size: "+fe.list.size);
		print("\nPrint fe.filters[0].name: "+fe.filters[0].name);
		print("\nPrint fe.game_info: "+fe.game_info(Info.Name,0));
		print("\nPrint fe.displays.name: "+fe.displays[fe.list.display_index].name);
		print("\nPrint list: "+list);
		print("\nPrint fe.displays.romlist: "+fe.displays[fe.list.display_index].romlist);
//		print("\nPrint fe.displays.filter_index: "+fe.displays[fe.list.display_index].filter_index);
//		print("\nPrint fe.Currentlist: "+Currentlist);
		print("\n---- Menu Overlay is Up1="+fe.overlay.is_up);
		if (fe.overlay.is_up){
			print("\n---- Menu Overlay is Up Now!!");

		}

		switch (ttype) {
			case Transition.StartLayout:
				if ( fe.list.display_index == -1) {
					print("\n---- Just Entered Displays Menu");	
				} 
				if 	( fe.list.display_index >= 0) {
					print("\n---- Just Entered Menu "+fe.list.name);
					print("\n---- Menu Overlay is Up2="+fe.overlay.is_up);
					if (!fe.overlay.is_up){
						
						
					} else {
					print("\n---- Menu Overlay is Down="+fe.overlay.is_up);
					}
				}
				break;
			case Transition.ShowOverlay:
				if (var == Overlay.Filters ){
					print("\n---- Just Entered Filter Menu");	
				}
				break;
				
				
		}			
				
				
//		if (ttype == Transition.ToNewList) {
//			if (fe.Currentlist.name == "" ) fe.list.romlist.append(fe.list.filters);
//			fe.list.romlist.append(fe.list.filters);
//		}
		return false;
	}
}
fe.plugin["FilterMenu"] <- FilterMenu();
