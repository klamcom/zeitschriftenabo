<?php
require "inc/db-connect.php";


$filter = $_POST['filter'] ?? '';
$name = $_POST['name'] ?? '';

if ($filter == 'nachNamen' && !empty($name)) {
    $name = "%$name%";
    $sql = "SELECT tblabo.aboID, tblkunden.vorname AS kundenVorname, tblkunden.nachname AS kundenNachname, 
            tblzeitschriften.titel AS zeitschriftTitel, tblabo.startdatum, tblabo.enddatum 
            FROM tblabo 
            JOIN tblkunden ON tblabo.fkkundenID = tblkunden.kundenID 
            JOIN tblzeitschriften ON tblabo.fkzeitschriftID = tblzeitschriften.zeitschriftenID 
            WHERE CONCAT(tblkunden.vorname, ' ', tblkunden.nachname) LIKE ?";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([$name]);

} else if ($filter === 'alleAbos') {

    $sql = "SELECT tblabo.aboID, tblkunden.vorname AS kundenVorname, tblkunden.nachname AS kundenNachname, 
            tblzeitschriften.titel AS zeitschriftTitel, tblabo.startdatum, tblabo.enddatum 
            FROM tblabo 
            JOIN tblkunden ON tblabo.fkkundenID = tblkunden.kundenID 
            JOIN tblzeitschriften ON tblabo.fkzeitschriftID = tblzeitschriften.zeitschriftenID";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();

} else {

    $datumBeding = $filter == 'nextMonat' ? "+1 MONTH" : "+2 MONTH";
    $datumAktuell = date('Y-m-01');
    $zielDatum = date('Y-m-01', strtotime($datumAktuell . " $datumBeding"));
    $endDatum = date('Y-m-01', strtotime($zielDatum . " +1 MONTH"));

    $sql = "SELECT tblabo.aboID, tblkunden.vorname AS kundenVorname, tblkunden.nachname AS kundenNachname, 
            tblzeitschriften.titel AS zeitschriftTitel, tblabo.startdatum, tblabo.enddatum 
            FROM tblabo 
            JOIN tblkunden ON tblabo.fkkundenID = tblkunden.kundenID 
            JOIN tblzeitschriften ON tblabo.fkzeitschriftID = tblzeitschriften.zeitschriftenID 
            WHERE tblabo.enddatum BETWEEN ? AND ?";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([$zielDatum, $endDatum]);
}

$abos = $stmt->fetchAll();
echo json_encode($abos);

?>

