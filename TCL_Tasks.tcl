# 1.	Groups Colors
#Create a little FEM and make some groups (Sets)
#Code a function, which associate a color for every group.
namespace eval ::TclTask:: {

}

# Method1 #
# Assign Colour to the list of Groups Provided #
proc ::TclTask::AutoAssignColorGroups {lst_GroupIds} {
	eval *createmark groups 1 $lst_GroupIds
	if {[hm_marklength groups 1]} {
		*autocolorwithmark groups 1
		return 1;
	}
	return 0;
}

# Method2 #
# Assign Colour to all Groups #
proc ::TclTask::AutoAssignColorAllGroups {} {
	*createmark groups 1 all
	if {[hm_marklength groups 1]} {
		*autocolorwithmark groups 1
		return 1;
	}
	return 0;
}

# Method3 #
# Assign Colour to all Groups #
proc ::TclTask::AutoAssignRandomColorGroups {} {
	*createmark groups 1 all
	if {[hm_marklength groups 1]} {
		foreach n_groupID [hm_marklength groups 1] {
			set n_ColorID [::TclTask::GetRandomColor]
			*setvalue groups id=$n_groupID color=$n_ColorID
		}
		return 1;
	}
	return 0;
}

# Get Random no. less than equal to 64 #
proc ::TclTask::GetRandomColor {} {
	set n_rand [expr rand()]
	set n_Color [expr round ($n_rand * 64)]
	return $n_Color;
}

#2.	Extend lines
#Create a model with 1D elements.
#Draw geometric lines based on these elements (length +20% for example)

# Get Dist between two nodes of 1D Element #
proc ::TclTask::Get1DElementLength {n_ElemId} {

	set lst_nodes [hm_getvalue elems id=$n_ElemId dataname=nodes]
	if {[llength $lst_nodes] == 2} {
		set lst_Dist [hm_getdistance nodes [lindex $lst_nodes 0] [lindex $lst_nodes 1] 0]
		set n_dist [lindex $lst_Dist 0]
		return $n_dist;
	}
	return -1;
}

proc ::TclTask::CreateLineBtn2Nodes {lst_nodes} {
	
	eval *createlist nodes 1 $lst_nodes
	if {[llength [hm_getlist nodes 1]] == 2} {
		*linecreatefromnodes 1 2 0.0 0.0 0.0
		set n_NewLineId [hm_latestentityid lines]
		return $n_NewLineId
	}
	return 0;
}


proc ::TclTask::ExtendLine1DElems {lst_ElemIds n_percent} {

	eval *createmark elems 1 $lst_ElemIds
	if {[hm_marklength elems 1]} {
		foreach n_ElemId $lst_ElemIds {
			set lst_nodes [hm_getvalue elems id=$n_ElemId dataname=nodes]
			set n_linelength [::TclTask::Get1DElementLength $n_ElemId]
			set n_LineID [::TclTask::CreateLineBtn2Nodes $lst_nodes]
			if {$n_LineID != 0} {
				
				set n_linelength [expr $n_linelength + ($n_linelength * ($n_percent/100.0))]
				*lineeditlength $n_LineID $n_linelength 1 -1
				
			}
		}
	}
}



