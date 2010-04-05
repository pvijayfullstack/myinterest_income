// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



(function($) {

    $(document).ready(function(){

        $('a.new_investment').live('click', function (e){
            var x = ($('#initial').clone());
            x = x.html();
            var new_id = new Date().getTime();
            var regexp = new RegExp("start", "g");
            var replaced  = x.replace(regexp, new_id);
            regexp = new RegExp("display: none;", "g");
            replaced = replaced.replace(regexp, "");
            $(replaced).find('input').attr('value','').end().appendTo('#new_investments');
            e.preventDefault();
        });

        $('.delete_investment').live('click', function (e){
            $(this).prev("input[type=hidden]").val("1");
            $(this).closest(".specific_investment").hide();
            return false;
        });
    });
})(jQuery);

