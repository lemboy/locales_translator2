function treeView () {
    $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
    $( document ).on('click', '.tree li.parent_li > span', function (e) {
        e.stopPropagation();
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', I18n.t('js.tree.titles.expand_branch')).addClass('glyphicon-plus-sign').removeClass('glyphicon-minus-sign');
        } else {
            children.show('fast');
            $(this).attr('title', I18n.t('js.tree.titles.collapse_branch')).addClass('glyphicon-minus-sign').removeClass('glyphicon-plus-sign');
        }
        e.stopPropagation();
    });
};
