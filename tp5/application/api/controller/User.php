<?php


namespace app\api\controller;


use think\File;
use think\captcha\Captcha;
use think\Controller;
use think\response\Json;

class User extends Controller
{
//    api例子
    public function read()
    {
        $uid = $this->request->param('id');
        $model = model('User');
        $data = $model::where('uid', $uid)->select();

//        return count($data);
        if (count($data)) {
            $code = 200;
        } else {
            $code = 404;
        }
        $data = [
            'code' => $code,
            'date' => $data
        ];
        return json($data);
    }

    //    添加权限
    public function huo()
    {
        $h = $this->request->param('h');
        $arr = ['auth_num' => $h];
        $model = model('Auth');
        $info = $model::where('auth_num', $h)->find();
        $data = '';
        if ($h === '') {
            $data = [
                'code' => '404',
                'msg' => '授权码不能为空'
            ];
            return json_encode($data);
        } elseif (strlen($h) != 6) {
            $data = [
                'code' => '404',
                'msg' => '授权码只能为六位数'
            ];
            return json_encode($data);
        } else {
            if ($info) {
                $data = [
                    'code' => '404',
                    'msg' => '数据已存在，请重新获取'
                ];
                return json_encode($data);

            } else {
                $data = [
                    'code' => '200',
                    'msg' => '数据添加成功'
                ];
                if ($model->save($arr)) {
                    return json_encode($data);
                }
            }
        }

//        if ($model->save($arr)){ return "添加成功";}


    }

//    获取权限表
    public function biao()
    {
        $model = model('Auth');
        $user = model('User');
        $id = $this->request->param('id');
        if ($id) {
            $model::destroy($id);
            return '删除成功';
        } else {
            $info = $model::select();
            for ($i = 0; $i < count($info); $i++) {
                $info1 = $user::where('auth_num', $info[$i]['auth_num'])->find();
                if ($info1) {
                    $info[$i]['state'] = '禁用';
                } else {
                    $info[$i]['state'] = '可用';
                }
            }
            return json($info);
        }

    }

//管理员注册
    public function zhuce()
    {
        $us = $this->request->param('user');
        $user = model('User');
        $u = json_decode($us, true);
        $auth_num = $u['auth_num'];
        $user_name = $u['user_name'];
        $user_password = $u['user_password'];
        $user_num = $u['user_num'];
        $user_email = $u['user_email'];
        $auth = model('Auth');
        $info1 = $auth::where('auth_num', $auth_num)->find();
        $info = $user::where('auth_num', $auth_num)->find();
        $info2 = $user::where('user_name', $user_name)->find();
        $data = [];
//        $yanzhen = [
//            'code'=> $auth_num
//        ];
//        $flag = $this->validate($yanzhen,[
//            'code|验证码'=>'require|captcha'
//        ]);
//        return $flag;
        $arr = [
            'user_name' => $user_name,
            'user_password' => $user_password,
            'user_num' => $user_num,
            'user_email' => $user_email,
            'auth_num' => $auth_num
        ];
//        $check_num= $u['check_num'];
//        $arr=[
//            'captcha'=>$check_num
//        ];
//        $config =    [
//            // 验证码字体大小
//            'fontSize'    =>    60,
//            // 验证码位数
//            'length'      =>    4,
//            // 关闭验证码杂点
//            'useNoise'    =>    false,
//        ];
        // 检测输入的验证码是否正确，$value为用户输入的验证码字符串
//        if( !captcha_check($check_num,'',$config ))
//        {
//            // 验证失败
//            return 'cuole';
//        }

//        $validate = new \app\index\validate\User;
//        if (!$validate->check($arr)) {
//            return dump($validate->getError());
//        }
        if ($info1) {
            if ($info) {
                $data = [
                    'code' => 404,
                    'error' => '授权码已被使用'
                ];
            } else {
                if ($info2) {
                    $data = [
                        'code' => 404,
                        'user_err' => '用户名已被注册'
                    ];
                } else {
                    if ($user->save($arr)) {
                        $data = [
                            'code' => 200,
                            'msg' => '注册成功'
                        ];
                    };
                }
            }
        } else {
            $data = [
                'code' => 404,
                'error' => '授权码无效'
            ];
        }
        return json($data);
    }

//    管理员登陆验证
    public function denglu()
    {
        $model = model('User');
        $user = $this->request->param('user');
        $user = json_decode($user, true);
        $info = $model::where('user_name', $user['username'])->find();
        if ($info) {
            if ($info['user_password'] == $user['password']) {
                $data = [
                    'code' => 200,
                    'msg' => '登陆成功'
                ];
            } else {
                $data = [
                    'code' => 404,
                    'password' => '密码错误'
                ];
            }
        } else {
            $data = [
                'code' => 404,
                'name' => '用户名不存在'
            ];
        }
        return json($data);
    }

//    用户注册
    public function state()
    {
        $pa = $this->request->file('imgurl');
        $id = $this->request->param();
        $people = model('People');
        if (empty($pa)) {
            $result['code'] = 404;
            $result['error'] = '请上传图片';

        } else {
            $shi = $people::where('username', $id['username'])->find();
            if ($shi) {
                $result['code'] = 404;
                $result['error'] = '用户已被注册';
            } else {
                $info = $pa->validate(['ext' => 'jpg,jpeg,png,gif,jfif', 'size' => 2048000])->move('../public/uploads');
                if ($info) {
                    //获取上传文件的详情信息
                    $info->getInfo();
                    //获取上传文件的名
                    $imgurl = '/uploads' . '/' . $info->getSaveName();
                    $id['imgurl'] = $imgurl;
                    $result['code'] = 200;
                    $result['msg'] = '上传成功';
                    $info1 = $people->save($id);
                    if ($info1) {
                        $result['code'] = 200;
                        $result['user'] = '注册成功';
                    } else {
                        $result['code'] = 404;
                        $result['error'] = '注册失败';
                    }
                } else {
                    $result['code'] = 404;
                    $result['error'] = $pa->getError();
                }

            }
        }


        return json($result);
//        return dump($info);
//              return dump($result);
    }

//          尝试显示图片成功
    public function xianshi()
    {
        $people = model('People');
        $info = $people::where('id', 1)->find();
        return $info['imgurl'];

    }

//    用户登陆验证
    public function usdenglu()
    {
        $people = model('People');
        $params = $this->request->param('user');
        $params = json_decode($params, true);
        $info = $people::where('username', $params['username'])->find();
        if ($info) {

            if ($info['password'] == $params['password']) {
                $result['code'] = 200;
                $result['msg'] = '登陆成功';
            } else {
                $result['code'] = 404;
                $result['password_err'] = '密码错误，请重新输入';
            }
        } else {
            $result['code'] = 404;
            $result['username_err'] = '用户名不存在';
        }
        return json($result);
    }

    //记住用户名和密码
    public function jizhu()
    {
        $people = model('People');
        $user =model('User');
        $params = $this->request->param();
        if (!empty($params['username'])){
            $info= $people::where('username',$params['username'])->find();
            return json($info);
        }elseif (!empty($params['user_name'])){
            $info =  $user::where('user_name',$params['user_name'])->findOrFail();
            return json($info);
        }


//        $username = $params['username'];
//        $user_name = $params['user_name'];

//            $info= $people::where('useranme',$username)->findOrFail();
//            $info =  $user::where('user_name',$params['user_name'])->findOrFail();
//            return json($info);

    }
}