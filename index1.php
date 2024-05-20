<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zeitschriftenabo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <form id="filterForm">
        <div class="form-check">
            <input class="form-check-input" type="radio" name="filter" value="nextMonat" id="nextMonat" checked>
            <label class="form-check-label" for="nextMonat">
                Nächstes Monat
            </label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="filter" value="nextnextMonat" id="nextnextMonat">
            <label class="form-check-label" for="nextnextMonat">
                Übernächstes Monat
            </label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="filter" value="nachNamen" id="nachNamen">
            <label class="form-check-label" for="nachNamen">
                Suche nach Namen
            </label>
            <input type="text" id="nameSuche" class="form-control mt-3" placeholder="Kundennamen eingeben" style="display:none;">
        </div>
    </form>
    <table class="table">
        <thead>
            <tr>
                <th>Abo Nr.</th>
                <th>Kunde</th>
                <th>Zeitschrift</th>
                <th>Startdatum</th>
                <th>Enddatum</th>
            </tr>
        </thead>
        <tbody id="ausgabe">        
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>

<script>
$(document).ready(function() {
    $('input[type=radio][name=filter]').change(function() {
        if (this.value == 'nachNamen') {
            $('#nameSuche').show();
            $('#ausgabe').html(''); 
        } else {
            $('#nameSuche').hide();
            ladeDaten(this.value);
        }
    });

    $('#nameSuche').on('input', function() {
        var suchText = $(this).val();
        if (suchText.length > 2) { nextnextMonat
            ladeDaten('nachNamen', suchText);
        }
    });

    function ladeDaten(filter, name = '') {
        $.ajax({
            url: 'abosabfragen.php', 
            type: 'POST',
            dataType: 'json',
            data: { filter: filter, name: name },
            success: function(data) {
                var rows = '';
                $.each(data, function(index, abo) {
                    rows += '<tr>' +
                            '<td>' + abo.aboID + '</td>' +
                            '<td>' + abo.kundenVorname + ' ' + abo.kundenNachname + '</td>' +
                            '<td>' + abo.zeitschriftTitel + '</td>' +
                            '<td>' + abo.startdatum + '</td>' +
                            '<td>' + abo.enddatum + '</td>' +
                            '</tr>';
                });
                $('#ausgabe').html(rows);
            }
        });
    }

    
    ladeDaten('nextMonat');
});
</script>
</body>
</html>

