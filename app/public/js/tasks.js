$(document).ready(function(){
		var today = new Date();
		var dd = today.getDate(); 
		var mm = today.getMonth()+1; 
		var yyyy = today.getFullYear(); 
		var current_date = mm.toString() + " " + dd.toString() + ", " + yyyy.toString();
/*
	Class: tasks
	Description: The done click and sidebar populate functions for sidebar: 
*/
	function notifications (t_id, message){
		var task_id = t_id
		var item = "";
		$.ajax({
			type: "POST",
			url: "/notification/new",
			data: {id: task_id, "message" : message }
		}).done(function(data){
			if (data.message != "") {
				item = "<div class='sidebar_task'>" +
				"<h4><i class='fa fa-calendar fa-6'></i>"+ current_date + "" +"</h4>" +
		        "<p>" + message + "</p>" +
			    "<a href='/notification'><i>View task</i></a>"+
		        "</div><!--close sidebar_task--> ";
				$("#sidebar_items").prepend(item);
			}
			else {
				var err = "Error adding notification for event on task no " + task_id
				item = "<div class='sidebar_task'>" +
				"<h4><i class='fa fa-calendar fa-6'></i>"+"Error!"+"</h4>" +
		        "<p>" + err + "</p>" +
			    "<a href='/notification'><i>View task</i></a>"+
		        "</div><!--close sidebar_task--> ";

				$("#sidebar_items").prepend(item);
			}
		});
	}

	function setReminder(msg, rem_time) {
	    setInterval(alertFunc(msg), rem_time);
	}

	function alertFunc(msg){
		$(".success_message_p").html("<div class='alert alert-warning alert-dismissible' role='alert'>" +
		  "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>" +
		  "<span aria-hidden='true'>&times;</span></button>" +
		  "<strong> Your task: " + msg + " is due by " + rem +
		"</div>");
	}

	function checkForReminders() {
		var msglist = $("#reminder_p");
		if (msglist.data("reminder_msg") != "empty" || msglist.data("reminder_msg") != "") {
			var rem = msglist.data("reminder_time");
			var rem_message = msglist.data("reminder_msg");

		    $(".success_message_p").html("<div class='alert alert-warning alert-dismissible' role='alert'>" +
				  "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>" +
				  "<span aria-hidden='true'>&times;</span></button>" +
				  "<strong> Your task: " + rem_message + " is due by " + rem +
				"</div>");
		    setReminder(rem_message, rem);
			msglist.data("reminder_time", "");
			msglist.data("reminder_msg", "");
		}
	}


	$(".task_done").click(function(e){
		var task_id = $(this).parents('li').attr('id');
		$.ajax({
			type: "POST",
			url: "/task/done",
			data: {id: task_id}
		}).done(function(data){
			if(data.status == 'done'){
				$("#" + data.id + ".task_done").html('<i class="fa fa-check-square-o fa-2x"></i>');
				//$("#" + data.id + ".task").wrapInner("<del>");
				notifications(task_id, "You just marked '" + data.content + "' as done.")
			}
			else {
				$("#" + data.id + ".task_done").html('<i class="fa fa-square-o fa-2x"></i>');
				notifications(task_id, "You changed '" + data.content + "' to 'not completed")
			}
		});
		e.preventDefault();
	});


	populateTaskSideBar();

	function populateTaskSideBar(){
		$.ajax({
			type: "GET",
			url: "/task/track_data",
			data: {"_action" : "Tasks"}
		}).done(function(data) {
			if(data.length != 0){
				$("#sidebar_items").html(data)
			} else {
				$("#sidebar_items").html("No task to display yet. <p><a href=\"/task/new\">Create new task</a>")
			}

		});
	};

});
