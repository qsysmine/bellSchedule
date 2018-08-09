var getQueryVariable = function(variable) {
  var query = window.location.search.substring(1);
  var vars = query.split('&');
  for (var i = 0; i < vars.length; i++) {
    var pair = vars[i].split('=');
    if (decodeURIComponent(pair[0]) == variable) {
      return decodeURIComponent(pair[1]);
    }
  }
  return null;
};
(function() {

  var adType = getQueryVariable("type"),
    selectedDates = [];


  if (["business", "birthday", "school", "club", "other"].indexOf(adType) == "-1") {
    adType = "other";
  }

  if (adType == "birthday") {
    $('#ctaPanel').hide();
    $('#pitchPanel').hide();
    $('h1').text("Write your birthday ad starting at $2.50.")
  } else {
    $('#birthdayPanel').hide();
    if(adType == "club") {
      $('h1').text('Write your club ad starting at $2.00 / day.');
    } else {
      $('h1').text('Write your ad starting at $3.00 / day.');
    }
  }



  var config = {
    apiKey: "AIzaSyD1fFhbnM4-GiEp1Jf1gDwU1gJyC2I6MSU",
    authDomain: "bellschedule-6db93.firebaseapp.com",
    databaseURL: "https://bellschedule-6db93.firebaseio.com",
    projectId: "bellschedule-6db93",
    storageBucket: "bellschedule-6db93.appspot.com",
    messagingSenderId: "581204545131"
  };

  firebase.initializeApp(config);

  firebase.auth().signInAnonymously().then(function() {
    renderCalculatedPrice(calculatePrice());
  }).catch(function(error) {
    // Handle Errors here.
    var errorCode = error.code;
    var errorMessage = error.message;
    // ...
  });

  $('#datePicker').datepicker({
    language: 'en',
    multipleDates: adType != "birthday",
    multipleDatesSeparator: ",",
    dateFormat: "dd M yyyy",
    minDate: new Date(new Date().getTime() + 24 * 60 * 60 * 1000),
    onRenderCell: function(date, cellType) {
      var disabledDays = [0, 6];
      if (cellType == 'day') {
        var day = date.getDay(),
          isDisabled = disabledDays.indexOf(day) != -1;
        return {
          disabled: isDisabled
        }
      }
    },
    onSelect: function(formattedDate, date, inst) {
      selectedDates = formattedDate.toUpperCase().split(",");
      renderCalculatedPrice(calculatePrice());
    }
  });

  $('#adBirthdayWishes').change(function() {
    renderCalculatedPrice(calculatePrice());
  });

  $('#adCTAText, #adURL').keyup(function() {
    renderCalculatedPrice(calculatePrice());
  });

  var getTimestamp = function() {
    return new Promise(function(resolve, reject) {
      var ref = firebase.database().ref('adApplicationUsers').child(firebase.auth().currentUser.uid).child('lastApplicationTimestamp');
      ref.set(firebase.database.ServerValue.TIMESTAMP).then(function() {
        ref.once("value").then(function(timestampSnapshot) {
          resolve(timestampSnapshot.val());
        });
      }).catch(reject);
    });
  };

  var renderPrice = function(price) {
    return "$" + (price / 100).toFixed(2)
  }

  var calculatePrice = function() {

    var costComponents = [];

    var numberOfDates = selectedDates.length;

    var adTypeCost = ["Advertisement base rate x " + numberOfDates + " days", 300 * numberOfDates];
    if (adType == "birthday") {
      adTypeCost = ["Advertisement birthday rate x " + numberOfDates + " days", 250 * numberOfDates];
    } else if (adType == "club") {
      adTypeCost = ["Advertisement club rate x " + numberOfDates + " days", 200 * numberOfDates];
    }

    costComponents.push(adTypeCost);

    var isReceivingBirthdayWishes = $('#adBirthdayWishes')[0].checked,
      birthdayWishCost = ["Birthday wishes x " + numberOfDates + " days", 50 * numberOfDates];

    if (isReceivingBirthdayWishes) {
      costComponents.push(birthdayWishCost);
    }

    var hasCTA = $('#adCTAText').val().trim() != "" || $('#adURL').val().trim() != "",
      ctaCost = ["Call to action button x " + numberOfDates + " days", 50 * numberOfDates];

    if (hasCTA) {
      costComponents.push(ctaCost);
    }

    var finalCost = 0;

    costComponents.map(function(costComponent) {
      finalCost += costComponent[1];
    });

    return [costComponents, ["Total cost", finalCost]];

  };

  var renderCalculatedPrice = function(priceCalculation) {
    $('#priceCalculation').html("");
    var costComponents = priceCalculation[0];
    var totalCost = priceCalculation[1];
    var costComponentElements = costComponents.map(function(costComponent) {
      return $('<div class="costComponent"><div class="costLabel">' + costComponent[0] + '</div><div class="costPrice">' + renderPrice(costComponent[1]) + "</div>")[0];
    });
    console.log(costComponentElements);
    var totalCostElement = $('<div class="costComponent"><div class="costLabel totalCost">' + totalCost[0] + '</div><div class="costPrice totalCost">' + renderPrice(totalCost[1]) + "</div>")[0];
    costComponentElements.map(function(costComponentElement) {
      $('#priceCalculation')[0].appendChild(costComponentElement);
    });
    $('#priceCalculation')[0].appendChild(totalCostElement);

  };

  $('#bellScheduleForm').submit(function(e) {
    e.preventDefault();
    $('#submitButton').attr("disabled", "true");
    var email = $('#emailField').val(),
      name = $('#nameField').val(),
      ctaText = $('#adCTAText').val(),
      adPitch = $('#adPitch').val(),
      studentName = $('#adBirthdayName').val(),
      birthdayWishes = $('#adBirthdayWishes')[0].checked,
      url = $('#adURL').val(),
      dates = selectedDates;

    if (dates == [] || email.trim() == "" || name.trim() == "" || ((adType == "birthday" && studentName.trim() == "") || (adType != "birthday" && adPitch.trim() == "")) || (url.trim() == "") != (ctaText.trim() == "") || !(grecaptcha &&
        grecaptcha.getResponse().length != 0)) {
      $('#submitButton').removeAttr("disabled");
      return alert("Something's not right.");
    }
    getTimestamp().then(function(timestamp) {
      var key = Math.floor(new Date().getTime() / 1000);
      firebase.database().ref("adApplications").child(key).set({
        emailAddress: email,
        userName: name,
        dates: dates,
        adType: adType,
        adPitch: (adType == "birthday" ? "Happy birthday " + studentName + "!" : adPitch),
        ctaText: (ctaText.trim() == "" ? null : ctaText.trim()),
        ctaURL: (url.trim() == "" ? null : url.trim()),
        birthdayWishes: (adType == "birthday" ? birthdayWishes : null),
        timestamp: timestamp,
        priceCalculation: calculatePrice(),
        owner: firebase.auth().currentUser.uid
      }).then(function() {
        location.assign("../thankYou?referenceNumber=" + key);
      }).catch(function(error) {
        console.log(error)
      });
    }).catch(function(error) {
      alert(error);
    });
  });
})();
