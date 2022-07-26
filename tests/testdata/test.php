<?php

require_once('lib/PDFreactor.class.php');

use com\realobjects\pdfreactor\webservice\client\PDFreactor as PDFreactor;
use com\realobjects\pdfreactor\webservice\client\LogLevel as LogLevel;
use com\realobjects\pdfreactor\webservice\client\ViewerPreferences as ViewerPreferences;

$content = file_get_contents('resources/content.html');

date_default_timezone_set('CET');

$pdfReactor = new PDFreactor('http://pdfreactor:9423/service/rest');

$config = array(
    'document' => $content,
    'logLevel' => LogLevel::DEBUG,
    'title' => 'Demonstration of PDFreactor PHP API',
    'author'=> 'Myself',
    'viewerPreferences' => array(
        ViewerPreferences::FIT_WINDOW,
        ViewerPreferences::PAGE_MODE_USE_THUMBS
    ),
    'userStyleSheets' => array(
        array(
            'content'=> '@page {' .
                            '@top-center {'.
                                'content: "PDFreactor PHP API demonstration";'.
                            '}'.
                            '@bottom-center {' .
                                'content: "Created on '.date('m/d/Y G:i:s A').'";' .
                            '}' .
                        '}'
        ),
        array( 'uri'=> 'resources/common.css' )
    )
);

$result = $pdfReactor->convertAsBinary($config);

if (preg_match('/^%PDF-/', $result)) {
    echo 'PDF generation was successful';
} else {
    throw new \Exception('Generated PDF file is invalid');
}
