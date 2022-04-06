<?php

namespace App;

use App\Common\Controller\ControllerInterface;
use FOS\RestBundle\Controller\Annotations\Get;
use Symfony\Component\HttpFoundation\Response;

class HomeController implements ControllerInterface
{

    #[Get('/')]
    public function index(): Response
    {
        return new Response('Привіт Степан!!!');
    }
}
