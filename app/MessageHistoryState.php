<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Capsule\Manager as DB;

class MessageHistoryState extends Model
{
    protected $primaryKey = 'message_mid';

    public function message()
    {
        return $this->belongsTo('App\Message');
    }

    public function contact()
    {
        return $this->hasOne('App\Contact', 'id', 'jidfrom');
    }

    public static function setState(string $jid)
    {
        MessageHistoryState::where('user_id', \App\User::me()->id)
                           ->where('jidfrom', $jid)->delete();

        $message = \App\Message::jid($jid);
        $message = (DB::getDriverName() == 'pgsql')
            ? $message->orderByRaw('published desc nulls last')
            : $message->orderBy('published', 'desc');
        $message = $message->first();

        $mhs = new MessageHistoryState;
        $mhs->jidfrom = $jid;
        $mhs->user_id = \App\User::me()->id;

        $mhs->message_mid = ($message && $message->published)
            ? $message->mid
            : null;
        $mhs->save();
    }

    public static function getState(string $jid): ?MessageHistoryState
    {
        return MessageHistoryState::where('user_id', \App\User::me()->id)
                                  ->where('jidfrom', $jid)
                                  ->first();
    }
}
