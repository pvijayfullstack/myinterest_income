// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



(function($) {

    $(document).ready(function(){
        $('a.new_investment').click(function (e){
            var x = ($('.specific_investment:first').clone());
            x.find('a').attr('value','');
            x = x.html();
            var new_id = new Date().getTime();
            var regexp = new RegExp("start", "g");
            var replaced = x.replace(regexp, new_id);

            $(replaced).appendTo('#new_investments');
            e.preventDefault();
        });

        $('.delete_investment').click(function (e){
            $(this).prev("input[type=hidden]").val("1");
            $(this).closest(".specific_investment").hide();
            e.preventDefault();
        });
    });
})(jQuery);

