<?php


namespace app\api\controller;

use think\captcha\Captcha;
use think\Controller;
use think\Image;

class Img extends Controller
{
    public function verify(){
        $config =    [
                // 验证码字体大小
    'fontSize'    =>    60,
    // 验证码位数
    'length'      =>    4,
    // 关闭验证码杂点
    'useNoise'    =>    false,
];
        ob_clean();
        $captcha = new Captcha($config);
        return $captcha->entry();
    }
    public function chatu(){
        $people = model("People");
        $shopping=model('Shopping');
        $user = $this->request->param('user');
        $goods = $shopping::where('username',$user)->select();
        $num = count($goods);
        $info = $people::where('username',$user)->find();
        $result['imgurl']=$info['imgurl'];
        $result['name']=$info['name'];
        $result['code']=200;
        $result['num']=$num;
        return json($result);

    }

}