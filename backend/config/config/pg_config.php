<?php
return [
    'merchantId'   => 'T_08887',
    'secretKey'    => 'abc', // UAT secret
    'use_uat'      => true,

    'uat_endpoint' => 'https://qa.phicommerce.com/pg/api/v2/initiateSale',
    'live_endpoint'=> 'https://secure-ptg.payphi.com/pg/api/v2/initiateSale',

    // 🔴 ADD THIS LINE (THIS FIXES YOUR ERROR)
    'appointment_return_url' =>
        'https://jimble.traitsolutions.in/Restapi/patient/appointment_return_handler.php',

    'currencyCode' => '356',
    'payType'      => '0'
];
