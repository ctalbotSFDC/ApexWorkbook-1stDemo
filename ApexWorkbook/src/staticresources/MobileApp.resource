$(document).on('SFDCReady', function() {
    // Apply ratchet list style after rendering of list
    SFDC.getViewController('contact-list').on('afterRender', function() { 
        this.view.$('ul').addClass('list'); 
    });
});

$('#contact-list').click(function(event) {
    SFDC.getViewController('contact-detail').set('record', event.target.id);
    $('#home').changePage($('#detail').show(), false, function() { $('#home').hide(); });
});

var showHome = function(from) {
    $(from).changePage($('#home').show(), true, function() { $(from).hide(); });
    return false;
}

var editView, isNewForm;
var showEdit = function(forCreate) {
    editView = SFDC.getViewController('contact-detail').showEdit('#edit #contact-edit', isNewForm = forCreate);
    editView.on('didInsertElement', function() { $('#edit').addClass('active'); });
    return false;
};
var saveForm = function() {
    editView.save(true).done(function(model) {
        if (isNewForm) SFDC.getViewController('contact-list').fetch();
        closeForm();
    });
    return false;
};
var closeForm = function() {
    $('#edit').removeClass('active');
    editView.remove();
    return false;
};