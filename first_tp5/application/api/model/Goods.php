<?php


namespace app\api\model;
use think\Model;

class Goods extends model
{
    public function add($num,$id){
        $this->update(['id'=>$id,'likes'=>$num]);
    }
}