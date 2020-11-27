<?php

namespace Movim;

use Movim\Widget\Wrapper;
use App\Message;

/**
 * This class handle incoming ephemeral messages and clear them
 * when the timer expires
 */
class EphemeralMessagesHandler
{
    protected static $instance;
    private $_mids = [];

    public static function getInstance()
    {
        if (!isset(self::$instance)) {
            self::$instance = new self();
        }

        return self::$instance;
    }

    public function __construct()
    {
        global $loop;
        $loop->addPeriodicTimer(1, function () {
            foreach ($this->_mids as $mid => $timer) {
                \Utils::debug('TIMER '.$mid.' '. $timer);
                if ($timer == 0) {
                    unset($this->_mids[$mid]);
                    $message = Message::where('mid', $mid)->first();

                    $wrapper = Wrapper::getInstance();
                    $wrapper->iterate('expired', $message);

                    $message->delete();
                } else {
                    $this->_mids[$mid] = $timer - 1;
                }
            }
        });
    }

    public function handle(Message $message)
    {
        \Utils::debug('HANDLE '.$message->mid.' '.$message->timer);
        $this->_mids[$message->mid] = (int)$message->timer;
    }
}
