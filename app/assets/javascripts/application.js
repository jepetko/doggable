// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require bootstrap
//= require_tree .

var commons = (function() {
    return {
        getModalDef : function(header,content) {
            return  '<div class="modal hide fade"> \
                     <div class="modal-header"> \
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>'
                        + '<h3>' + header + '</h3> \
                     </div> \
                     <div class="modal-body">'
                        + '<p>' + (content || '') + '</p> \
                    </div> \
                    <div class="modal-footer"> \
                        <a href="#" class="btn">Close</a> \
                        <a href="#" class="btn btn-primary">Save changes</a> \
                    </div> \
                </div>';
        },
        createModal : function(header,content) {
            $('body').append(this.getModalDef.apply(this,arguments));
            var modal = $('.modal').modal();
            modal.on('hidden', $.proxy(function () {
                this.remove();
            },modal));
        }
    }
})();

var dogsView = (function(commons) {
    return {
        addSkills : function(header, content) {
            commons.createModal(header);
            $.ajax({
                url: content,
                beforeSend: function ( xhr ) {
                    xhr.overrideMimeType("text/plain; charset=x-user-defined");
                }
            }).done(function ( data ) {
                $('.modal-body').append(data);
            });
        }
    }
})(commons);

/////////////////////////////////
/// navigation

/*
$(function() {
    var d=300;
    $('#navigation a').each(function(){
        var paddingTop = $(this).css('paddingTop');
        $(this).css('margin-top', '-' + paddingTop);
    });

    $('#navigation > li').hover(
        function () {
            $('a',$(this)).stop().animate({
                'marginTop':'-2px'
            },200);
        },
        function () {
            var $t = $('a',$(this));
            var paddingTop = $t.css('paddingTop');
            $('a',$(this)).stop().animate({
                'marginTop': '-' + paddingTop
            },200);
        }
    );
});
*/

//TODO: modernizer; use prefixed function
$(function() {
    $('.plate').bind("click", function() {
        $(this).addClass('fall');
        $(this).bind("animationend", function(){
            var evt = arguments[0];
            var orig = evt.originalEvent;
            if( orig.animationName == "anim") {
                $(this).css("transform", "rotateX(0deg)");
            } else if( orig.animationName == "anim2") {
                $(this).css("transform", "rotateX(-30deg)");
            } else if( orig.animationName == "anim3" ) {
                $(this).css("transform", "rotateX(0deg)");
            }
        });
    });
});

////////////////////////////////////// for dogs form

$(function() {
    $("#dog_birthday").datepicker();
});

$(function() {
    $("#dog_picture").bind('change', function() {

    })
    $("#dog_picture_trigger").bind('click', function() {
        $("#dog_picture").trigger('click');
    })
})