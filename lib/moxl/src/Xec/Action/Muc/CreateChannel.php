<?php

namespace Moxl\Xec\Action\Muc;

use Moxl\Xec\Action;
use Moxl\Stanza\Muc;

class CreateChannel extends Action
{
    protected $_to;
    protected $_name;

    public function request()
    {
        $this->store();
        Muc::createChannel($this->_to, $this->_name);
    }

    public function handle($stanza, $parent = false)
    {
        $this->pack($this->_to);
        $this->deliver();
    }
}