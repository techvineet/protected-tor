function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
  return false;
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

function load_categories ( category, subcategory, flag ) {
  if( flag ) {
    $.ajax({
      url: "/categories/"+encodeURIComponent(category.val())+"/"+encodeURIComponent(subcategory.val()),
      success: function(data) {
        subcategory.select2({
          data: data.results,
          placeholder: "Sub Category",
          initSelection: select2InitSelection,
          width: "220px"
        });
        category.select2("val",data.category)
        subcategory.select2("val",data.subcategory);
      }
    });
  } else {
    $.ajax({
      url: "/categories/"+encodeURIComponent(category.val()),
      success: function(data) {
        subcategory.select2({
          data: data.results,
          placeholder: "Sub Category",
          initSelection: select2InitSelection,
          width: "220px"
        });
      }
    });
  }
}

select2InitSelection = function (element, callback) {
  $(element).select2("data", {
    id: element.val(), 
    text: element.val()
  });
}

$(function(){
  $('div.btn-group').each(function(){
    var group   = $(this);
    var form    = group.parents('form').eq(0);
    var name    = group.attr('data-toggle-name');
    var hidden  = $('input[name="' + name + '"]', form);
    $('button', group).each(function(){
      var button = $(this);
      button.bind('click', function(){
        hidden.val($(this).val());
      });
      if(button.val() == hidden.val()) {
        button.addClass('active');
      }
    });
  });  
  //https://github.com/plentz/jquery-maskmoney
  $(".currency_field").maskMoney({
    precision: 0,
    defaultZero: false
  });
  $(".numeric_field").maskMoney({
    precision: 0,
    thousands: "",
    defaultZero: false
  });
  $('input, textarea').placeholder();
  $("#sort_job_list").select2({
    placeholder: "Sort By",
    minimumResultsForSearch: '10',
    width: "150px"
  })
  $("#job_category_name").select2({
    placeholder: "Category",
    width: "220px"
  });
  $("#job_subcategory_name").select2({
    placeholder: "Sub Category",
    width: "220px",
    data: [],
    initSelection: select2InitSelection
  });
  $('.datepicker').datepicker({
    showOtherMonths: true,
    selectOtherMonths: true,
    dateFormat: "yy-mm-dd",
    minDate: 0
  })
  $( "#job_start_date" ).datepicker({
    showOtherMonths: true,
    selectOtherMonths: true,
    dateFormat: "yy-mm-dd",
    minDate: 0,
    onClose: function( selectedDate ) {
      $( "#job_end_date" ).datepicker( "option", "minDate", selectedDate );
    }
  });
  $( "#job_end_date" ).datepicker({
    showOtherMonths: true,
    selectOtherMonths: true,
    dateFormat: "yy-mm-dd",
    minDate: 0,
    onClose: function( selectedDate ) {
      $( "#job_start_date" ).datepicker( "option", "maxDate", selectedDate );
    }
  });
  $('#job_category_name').on("change", function(e) {
    $("#job_subcategory_name").select2("val","");
    load_categories($(this), $('#job_subcategory_name'), false);
  });
  $('#sort_job_list').on("change", function(e) {
    $("#sort_jobs").submit();
  });
})