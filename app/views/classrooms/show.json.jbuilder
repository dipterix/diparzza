json.extract! @classroom, :id, :num, :name, :created_at, :updated_at

html = '<div class="align-center"><h6 class="separator">Ooooops!</h6><p>You are not authorized to view this page. Please contact your teacher in order to enroll you into this class</p></div>'


unless @classroom.user!=current_user && Classenroll.find_by(user_id: current_user.id, classroom_id: @classroom.id, ispassed: true).nil?
	if params[:target]=='intro'
		html = render 'classrooms/shared/classintro'
	elsif params[:target]=='member'
		html = render 'classrooms/shared/stunamelist'
	elsif params[:target]=='announce'
		html = render 'classrooms/shared/announcement'
	elsif params[:target]=='forum'
		html = render 'classrooms/shared/forum'
	elsif params[:target]=='process'
		html = render 'classrooms/shared/courseschedule'
	else
		html = '<h6 class="align-center">This page is Under Construction</h6>'
	end
end
json.extract! html, :to_s