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
/// for modernizr


var crossBrowserEvtNames = {
    //transition
    'WebkitTransition' : 'webkitTransitionEnd',
    'MozTransition'    : 'transitionend',
    'OTransition'      : 'oTransitionEnd',
    'msTransition'     : 'MSTransitionEnd',
    'transition'       : 'transitionend',
    //animation
    'WebkitAnimation' : 'webkitAnimationEnd',
    'MozAnimation'    : 'animationend',
    'OAnimation'      : 'oAnimationEnd',
    'msAnimation'     : 'MSAnimationEnd',
    'animation'       : 'animationend'
    };


/////////////////////////////////
/// for fonts

WebFontConfig = {
    google: { families: [ 'Quicksand', 'Akronim', 'Ubuntu Mono' ] }
};

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

function CssUtils() {}
CssUtils.addRule = function(rule) {
    if( document.styleSheets && document.styleSheets.length ) {
        document.styleSheets[0].insertRule( rule, 0 );
    } else {
        var s = document.createElement( 'style' );
        s.innerHTML = rule;
        document.getElementsByTagName( 'head' )[ 0 ].appendChild( s );
    }
}
CssUtils.getPrefix = function(str) {
    var result = /.*\-/g.exec(str);
    if( result && result.length>0 ) return result[0];
    return '';
}
CssUtils.fromCamelToCss = function(str) {
    return str.replace(/([A-Z])/g, function(str,m1){ return '-' + m1.toLowerCase(); });
}

if( typeof Array.prototype.last !== 'function' ) {
    Array.prototype.last = function() {
        if( this.length == 0 ) return null;
        return this[this.length-1];
    }
}


$(function() {
    (new function() {
        var startDelay = 1000,
            animstartDelay = 1000,
            flappingDegrees = [100,80,70,60,50,40,30,20,10,5,0],
            flappingDelays = [startDelay], //Note: flappingDelays will be filled later
            mainFrom = '180deg', trans = '10px', mainTo = flappingDegrees[0]*(-1);

        this.getPlate = function() {
            return $('.plate');
        }
        this.initVars = function() {
            var transform = Modernizr.prefixed('transform');
            var transformCss = CssUtils.fromCamelToCss(transform);
            var keyFrame = '@' + CssUtils.getPrefix(transformCss) + 'keyframes';  //issue modernizr

            var mainRule = keyFrame + ' animstart {' +
                            ' from {' + transformCss + ':rotateX( ' + mainFrom + 'deg ) translate(0px,' + trans + ')}'+
                            ' to {' + transformCss + ':rotateX( ' + mainTo + 'deg ) translate(0px,' + trans + ') }'+
                            '}';
            CssUtils.addRule(mainRule);

            for(var i=0;i<flappingDegrees.length-1;i++) {
                var f = (i%2===0)?-1:1;
                var from = flappingDegrees[i] * f;
                var to = flappingDegrees[i+1] * f * (-1);
                var rule = keyFrame + ' plate' + i + ' { '+
                            ' from {' + transformCss + ':rotateX( ' + from + 'deg ) translate(0px,' + trans + ')}'+
                            ' to {' + transformCss + ':rotateX( ' + to + 'deg ) translate(0px,' + trans + ') }'+
                            '}';
                console.log(rule);
                CssUtils.addRule(rule);
                flappingDelays.push( Math.round(flappingDelays.last() * .75) );
            }
        }

        this.init = function() {
            this.initVars();
            var evtName = crossBrowserEvtNames[ Modernizr.prefixed('animation') ];
            this.getPlate().bind(evtName, $.proxy( function(evt) {
                var plate = this.getPlate();
                var orig = evt.originalEvent;
                if( orig ) {
                    var name = orig.animationName;
                    switch(name) {
                        case 'animstart':
                            plate.css("transform", "rotateX(" + mainTo + ") translate(0px," + trans + ")");
                            break;
                        default:
                            var postfix = parseInt(/\d+$/.exec(name)[0]);
                            var f = (postfix%2==0) ? 1 : -1;
                            var endValue = flappingDegrees[postfix+1] * f;
                            console.log( "rotateX(" + endValue + "deg) translate(0px," + trans + ")" );
                            plate.css("transform", "rotateX(" + endValue + "deg) translate(0px," + trans + ")");
                    }
                }
            },this));
        }
        this.doRotate = function() {
            var anim = '', animDelay = '';
            var tmpAnim = animstartDelay;
            $.each(flappingDelays, function(idx,val) {
                if( anim!='' ) {
                    anim += ', ';
                    animDelay += ', ';
                }
                anim += 'plate' + idx + ' ' + val + 'ms';
                animDelay += tmpAnim;
                animDelay += 'ms';
                tmpAnim += val;
            });
            var plate = this.getPlate();
            anim = 'animstart ' + animstartDelay + 'ms,' + anim;
            animDelay = '0ms,' + animDelay;
            var animKeyword = Modernizr.prefixed('animation');
            console.log( anim );
            console.log( animDelay );
            plate.css( animKeyword, anim);
            plate.css( animKeyword + '-delay', animDelay);
            plate.css( animKeyword + '-timing-function', 'ease-start');
        }
        this.start = function() {
            this.doRotate();
        }
        this.init();
    }).start();
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