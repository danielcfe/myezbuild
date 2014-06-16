var timeout = null;
$(document).on('ready',function(){

$form = $('#lead'); 
  $form.on('submit',function(e) {
    e.preventDefault();
    var infoLead = $(this).serialize();
    $.ajax({
      type: "post",
      url: "/lead",
      data: infoLead,
      async: false,
      statusCode: {
        412: function(response) {
          errors = $.parseJSON(response.responseText)
          showError(errors);
        }
      },
      success: function(x,y){
        alert('Created Successfully Lead');
        $form[0].reset();
        $.fancybox.close()
      }
      });
  });

  $(".fancymodal").fancybox({
    maxWidth  : 800,
    maxHeight : 600,
    fitToView : false,
    width   : 300,
    height    : 400,
    autoSize  : false,
    closeClick  : false,
    beforeLoad: function(x,s,a){
      $('html,body').css('height','auto')
      $('#lead #type').val($(this.element).data('type'));
    }
  }).fancybox({padding : 0});

  $(".fancybox").fancybox({
    openEffect  : 'none',
    closeEffect : 'none',
    nextEffect  : 'none',
    prevEffect  : 'none',
    padding     : 0,
    margin      : [20, 60, 20, 60],
    beforeLoad: function(){
      $('html,body').css('height','auto')
    }
  });

  $('#lead input').tooltipster({
    offsetY: 2,
    trigger: 'show',
    position: 'right',
    positionTracker: true
  });

  function showToolTip(inputTarget) {
    inputTarget.tooltipster('show');
    timeout = setTimeout(function(){
      inputTarget.tooltipster('hide');
        },5000);
  }

  function showError(data){
    var first = false;
    var target = null;
    $.each(data, function(key,value) {
      value = value[0];
      target = $('[name="'+key+'"]');
      if(!first){
        target.focus();
        first = true;
      }
      target.tooltipster('content', value)
      showToolTip(target);
    });
  }

  $('.panel-collapse.collapse').on('shown.bs.collapse', function () {
    $(this).parent().find("a[data-toggle='collapse']").html('READ LESS')
  });

  $('.panel-collapse.collapse').on('hidden.bs.collapse', function () {
    $(this).parent().find("a[data-toggle='collapse']").html('READ MORE')
  });

});