<?php

use App\Kernel;

require_once dirname(__DIR__) . '/vendor/autoload_runtime.php';

if (isset($_SERVER['PROXY_AUTH']) && (!isset($_SERVER['HTTP_X_AUTH']) || $_SERVER['HTTP_X_AUTH'] !== $_SERVER['PROXY_AUTH'])) {
    header('HTTP/1.0 403 Forbidden');
    echo 'You are forbidden!';
    die;
}

return function (array $context) {
    return new Kernel($context['APP_ENV'], (bool)$context['APP_DEBUG']);
};
