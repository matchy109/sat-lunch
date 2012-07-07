function change_rice_options(){
    var sel_dish = document.order.dish.selectedIndex;

    if(sel_dish == 3){
        document.order.rice.value = '-';
		document.order.rice.disabled = true;
    }else{
        document.order.rice[0].selected = true;
        document.order.rice.disabled = false;
    }
}

function set_attendance(){
    var sel_attendance = document.getElementsByName("attendance");
   
    if (sel_attendance[1].checked) {
        document.order.rice.disabled = true;
        document.order.dish.disabled = true;
        document.order.rice.value = '-';
        document.order.dish.value = '-';
    }else{
        document.order.rice.disabled = false;
        document.order.dish.disabled = false;
        document.order.rice[0].selected = true;
        document.order.dish[0].selected = true;
    }
}
