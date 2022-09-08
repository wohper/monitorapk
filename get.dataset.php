<?php
/**
 * Questo è uno script prototipo per ottenere un dataset da indicepa.gov.it
 * Author: wohper
 */

$datasetFilename = $argv[1];
$endPoint = 'https://indicepa.gov.it/ipa-dati/datastore/dump/d09adf99-dc10-4349-8c53-27b1e5aa97b6?bom=True&format=tsv';

# Test argomenti
if(!$datasetFilename){
	echo sprintf("usage: %s [OUTPUT FILENAME]".PHP_EOL, $argv[0]);
	die();
}

# Evito di sovrascrivere
if(file_exists($datasetFilename)){
	echo sprintf("**ERROR. `%s` esiste già. Utilizza un nuovo percorso.".PHP_EOL, $datasetFilename);
	die();
}

# Verifico che il percorso sia scrivibile
file_put_contents($datasetFilename, null);
if(!is_file($datasetFilename) && !is_writable($datasetFilename)){
	echo sprintf("**ERROR. `%s` non è un percorso valido.".PHP_EOL, $datasetFilename);
	die();
}

# Creo un file temporaneo e procedo al download del dataset
$rawDataFilename = tempnam("/tmp", "indicepa");
if(!file_put_contents($rawDataFilename, file_get_contents($endPoint))){
	echo "Download dataset fallito.".PHP_EOL;
	die();
}
echo sprintf("Dataset scaricato in `%s`".PHP_EOL, $rawDataFilename);

# Normalizzo i dati
echo "Normalizzo i dati: ";
$data = trim(file_get_contents($rawDataFilename));
$i = 0; $e = 0; $c = 0;
foreach(explode(PHP_EOL, $data) as $k => $v){

	if($k == 0){ continue; }

	$fields = explode("\t", $v);
	$fields[29] = trim(trim($fields[29], '"'));
	
	if(trim($fields[29])){
	
		$url = parse_url($fields[29]);
		if(!isset($url['scheme'])){
			$fields[29] = sprintf('http://%s', $fields[29]);
		}	
	
		file_put_contents($datasetFilename, sprintf("%s\tWeb\t%s".PHP_EOL, $fields[1], $fields[29]), FILE_APPEND); 
		echo ".";
		$i++;
	}else{
		echo "e";
		$e++;
	}
	
	$c++;

}
echo " Fatto".PHP_EOL;
echo sprintf("Ho trovato %d record. %d non hanno un sito associato".PHP_EOL, $c, $e);

if(unlink($rawDataFilename)){
	echo "Ho rimosso i file temporanei".PHP_EOL;
}

echo sprintf("Il tuo dataset è disponibile qui: `%s`.".PHP_EOL,  realpath($datasetFilename));


