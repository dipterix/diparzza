init_edit_table = function(tableclass){
	ttr = $("." + tableclass + " tbody tr")
	thead = $("." + tableclass + " thead")
	tbody = $("." + tableclass + " tbody")
	$("."+tableclass).after('<div id="edit-new" style="visibility:hidden">New Line</div>')
	newedit = $("#edit-new")
	var safeHtml = function(s){
		$(".jsdebug").text(s)
		s = $(".jsdebug").text()
		if(s!=null && s.search(/script.*>/g) != -1){
			
			href_a = s.match(/<.*script.*\/.*script.*>/g)
			for(var index=0; 
					index< href_a.length;
					index++){
				s = s.replace(/<.*script.*\/.*script.*>/g, '')
			}
			
		}
		return s
	}
	change_table_color = function(){
		tbody.children('tr:even').addClass('otherline')
		tbody.children('tr:odd').removeClass('otherline')
		tbody.children('tr').removeClass('twarning')

		$('.delRow:first').css('visibility', 'hidden')
		$('.minus:first').css('backgroundColor', '#fff')
		$('.delRow:not(:first)').css('visibility', '')
		tbody.children('tr:last').addClass('twarning')
	}
	newedit.hover(
		function(){
			$(this).stop(true);
			newedit.animate({
				'height': '60px',
				'color' : '#000',
				'marginBottom' : '10px'
			})
		},
		function(){
			$(this).stop(true);
			newedit.animate({
				'height': '30px',
				'color' : 'transparent',
				'backgroundColor': 'transparent',
				'marginBottom' : '40px'
			})
		})
	$("."+tableclass).before('<div class="jsdebug" style="display:none"></div>')
	//delete row
	register_delete_btn = function(){
		$('.delRow:not(:first)').parent().click(function(){
			$(this).parent().remove()
			change_table_color()
		})
	}
	// add row
	newedit.click(function(){
		insertHtml = "<tr>"+tbody.children('tr').last().html() +"</tr>";
		tbody.append(insertHtml)
		register_delete_btn()
		change_table_color()
	})
	
	var activate_edit_table = function(){
		container = $("." + tableclass + " tbody tr td:not('.minus'), ." + tableclass + " thead tr th:not('.minus')")
		window.cellediting = undefined
		// pre process
		newedit.css('visibility', '');
		newedit.fadeIn()
		container.animate({
			height: "+=17px",
			opacity: '0.1'
		}, function(){
			$(this).each(function(){
				w = parseInt($(this).css('width'))
				html = $(this).html().trim()
				s = "<input type='text' class='form-control flat edit-table-input' ></input>"
				$(this).html(s)
				$(this).children('input').val(html)
				$(this).children('input').css({
					'width' : (w-10)+"px",
					'max-width': (w)+'px',
					'min-width': '90px'
				})
				$(this).css({
					'width': w+"px",
					'min-width': '100px'
				})
			})
		}).fadeTo(550,1)
		if($('.minus').length == 0){
			thead.children('tr').append("<th class='minus'></th>")
			tbody.children('tr').append("<td class='minus'><span class='glyphicon glyphicon-minus delRow'></span></td>")
			// delete row register_delete_btn
			
			// arrange color & style
			change_table_color()
		}else{
			$('.minus').show()
		}
		register_delete_btn()
	}
	
	var deactivate_edit_table = function(){
		if(sessionStorage.deactivate_edittable != undefined){
			delete(sessionStorage.deactivate_edittable)
			return null;
		}
		sessionStorage.deactivate_edittable = true
		container = $("." + tableclass + " tbody tr td:not('.minus'), ." + tableclass + " thead tr th:not('.minus')")
		$('.minus').hide();
		window.cellediting = undefined
		newedit.css('visibility', 'hidden');
		container.animate({
			opacity: '0.1'
		},function(){
			$(".minus").hide()
			$(this).each(function(){
				text = $(this).children('.edit-table-input').val()
				$(this).html('')
				text = safeHtml(text)
				$(this).html(text)
			})
		}).animate({
			height: "-=17px",
			opacity: '1'
		})
		$(".edit-table tbody tr td:not(:last), .edit-table thead tr th:not(:last)").removeAttr('style')
		tbody.children('tr').children('th').remove('.minus')
		
		thead.children('tr').children('td').remove('.minus')
		delete(sessionStorage.deactivate_edittable)
		
	}

	end_edit = function(){
		$(".edit-confirm").off('click', end_edit)
		
		deactivate_edit_table()
		$(".edit-confirm").fadeOut(500,function(){
			$('.edit-start').fadeIn(500)
		})
		setTimeout(function(){
			$(".edit-confirm").on('click', end_edit);
		},1000);
	}
	$(".edit-confirm").click(end_edit)
		
	start_edit = function(){
		$('.edit-start').off('click', start_edit)
		activate_edit_table()
		$('.edit-start').fadeOut(500, function(){
			$('.edit-confirm').fadeIn()
		})
		setTimeout(function(){
			$(".edit-start").on('click', start_edit);
		},1000);
	}
	$('.edit-start').click(start_edit)
	
	$('td a').attr('target', '_blank')
	
	$('.edit-start').show()
}
	
	
