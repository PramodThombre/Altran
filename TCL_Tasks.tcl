# 1.	Groups Colors
#Create a little FEM and make some groups (Sets)
#Code a function, which associate a color for every group.
namespace eval ::TclTask:: {

}

#Method1
proc ::TclTask::AutoAssignColorGroups {lst_GroupIds} {
	eval *createmark groups 1 $lst_GroupIds
	if {[hm_marklength groups 1]} {
		*autocolorwithmark groups 1
		return 1;
	}
	return 0;
}

#Method2
proc ::TclTask::AutoAssignColorAllGroups {} {
	*createmark groups 1 all
	if {[hm_marklength groups 1]} {
		*autocolorwithmark groups 1
		return 1;
	}
	return 0;
}

#Method3
proc ::TclTask::GetRandomColor {} {
	set n_rand [expr rand()]
	set n_Color [expr round ($n_rand * 64)]
	return $n_Color;
}

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
