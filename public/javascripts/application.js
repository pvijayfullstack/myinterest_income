// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



(function($) {

    $(document).ready(function(){

        $('a.new_investment').live('click', function (e){
            var x = ($('#initial').clone());
            console.log("checking here");
            x.find('a').attr('value','');
            x = x.html();
            var new_id = new Date().getTime();
            var regexp = new RegExp("start", "g");
            x = x.replace(regexp, new_id);
            regexp = new RegExp("display: none;", "g");
            x = x.replace(regexp, "");
            $(x).appendTo('#new_investments');
            e.preventDefault();
        });

        $('.delete_investment').live('click', function (e){
            console.log("$(this) ", $(this));
            $(this).prev("input[type=hidden]").val("1");
            $(this).closest(".specific_investment").hide();
            return false;
        });
    });
})(jQuery);

