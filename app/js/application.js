var ContactListView = Stapes.subclass({
    constructor: function () {
        /*Set up things we will need later*/
        this.contactServiceDeleteURL = "API/ContactService.cfc?method=removeContactByID";
        this.cancelEditMessage = "Are you sure you want to delete this contact?";
        this.deleteConfirmMessage = "Are you sure you want to cancel?";
        this.$contactDetails = $("#mainContent .contactDetail");
        this.$deleteContactElements = $(".deleteContact");
        this.$filterText = $("#filterText");
        this.$contactDataElements = $(".contactData");
        this.$searchResultsContainer = $(".wrapperContainer");
        this.bindEventHandlers();
    },

    bindEventHandlers: function () {

        /*What happens when you click for contact details*/
        this.$contactDetails.on('click', function (e) {
            var $target = $(e.target);
            e.preventDefault();
            this.$contactDetails.not(e.target).parentsUntil(".contactItem").siblings(".contactData").slideUp();
            $target.parentsUntil(".contactItem").siblings(".contactData").slideToggle();
        }.bind(this));

        /*What happens when you click to delete a contact*/
        this.$deleteContactElements.on('click', function (e) {
            var result = window.confirm(this.deleteConfirmMessage);
            var $target = $(e.target);
            if (result == false) {
                e.preventDefault();
            } else {
               $.post(this.contactServiceDeleteURL, {contactID: $target.data("contactid") }, function(){window.location.assign("index.cfm");} );
            };
        }.bind(this));

        /*What happens when you type in a box.... this method is getting a bit long, but it's ok for now*/
        this.$filterText.on('keyup', function (e) {
            if (event.which == 13) {
                e.preventDefault();
            }
            var isShowAll = e.target.value.length === 0;
            var matchRegex = new RegExp(e.target.value, 'i');
            self = this;

            //close everything then look for our matching elements
            this.$contactDataElements.slideUp();
            this.$searchResultsContainer.find(".contactItemWrapper").hide().map(function () {
                var contactItem = this;
                if (
                    $(this).map(function () {
                        return $(this).find(".filterableContent").text();
                    }).get().join().search(matchRegex) != -1
                    ) {
                    return contactItem; //this stuff matches, so we'll show it
                }

            }).show();

        }.bind(this));
    }
});

ContactFormView = Stapes.subclass({
    constructor: function () {
        this.$cancelContactForm = $(".cancelContactForm");
        this.bindEventHandlers();
    },

    bindEventHandlers: function () {
        /*What happens when you click cancel on the form page*/
        this.$cancelContactForm.on('click', function (e) {
            var result = window.confirm(this.cancelEditMessage);
            if (result == false) {
                e.preventDefault();
            } else {
                window.location.assign("index.cfm");
            };
        }.bind(this));
    }
});


var ContactController = Stapes.subclass({
    constructor: function () {
        this.model = {}; //If we decide to go all single-pagey, we'll want to implement this. For now, it's hook.
        this.contactInputView = new ContactListView(this.model)
        this.contactForm = new ContactFormView(this.model)
    }
});

var controller = new ContactController();