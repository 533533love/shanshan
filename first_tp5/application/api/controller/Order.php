<?php


namespace app\api\controller;
use tests\InfoTest;
use think\Controller;
use think\Db;
use think\db\Where;

class Order extends Controller
{
    //添加商品到购物车
    public function buy(){
        $goods = $this->request->param();
        $shopping = model('Shopping');
        $info1=$shopping->where('username',$goods['username'])->order('id','desc')->select();
        if (count($info1)!=0){
            for ($i=0;$i<count($info1);$i++){
                if ($info1[$i]['goodsid']==$goods['id']){
                    $id=$info1[$i]['id'];
                    $num = $info1[$i]['goodsnum']+$goods['num'];
                    $price=$num*$goods['price'];
                    $goodsinfo=[
                        'goodsnum'=>$num,
                        'total'=>$price
                    ];
                    $info2 = $shopping::where('id',$id)->update($goodsinfo);
                    if ($info2){
                        $result['code']=201;
                        $result['msg']=$id;
                    }else{
                        $result['code']=404;
                        $result['error']='加入购物车失败';
                        $result['msg']=$i;
                    }
                    return json($result);
                }else{
                    if ($i==count($info1)-1){
                        $total = $goods['price'];
                        $goodsinfo = [
                            'username'=>$goods['username'],
                            'goodsname'=>$goods['name'],
                            'goodsimg'=>$goods['img'],
                            'goodsprice'=>$goods['price'],
                            'goodsnum'=>$goods['num'],
                            'total'=>$total,
                            'goodsid'=>$goods['id']
                        ];
                        $info = $shopping->save($goodsinfo);
                        if ($info){
                            $result['code']=203;
                            $result['msg']='加入购物车成功';
                        }else{
                            $result['code']=404;
                            $result['error']='加入购物车失败';
                        }
                    }
                }
            }

        }else{
            $total = $goods['price'];
            $goodsinfo = [
                'username'=>$goods['username'],
                'goodsname'=>$goods['name'],
                'goodsimg'=>$goods['img'],
                'goodsprice'=>$goods['price'],
                'goodsnum'=>$goods['num'],
                'total'=>$total,
                'goodsid'=>$goods['id']
            ];
            $info = $shopping->save($goodsinfo);
            if ($info){
                $result['code']=200;
                $result['msg']='加入购物车成功';
            }else{
                $result['code']=404;
                $result['error']='加入购物车失败';
            }
        }
        //订单号
//        $osn = date('ymd') . str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);
        return json($result);
    }
    //加载购物车页面
    public function shop(){
        $params = $this->request->param();
        $shopping = model('Shopping');
        $state = '';
        if (!empty($params['user'])){
            if (!empty($params['flag'])){
                if ($params['flag']==2){
                    $state = 1;
                }else{
                    $state=0;
                }
                $info = $shopping::where('username',$params['user'])->order('id','desc')->selectOrFail();
                for($i=0;$i<count($info);$i++){
                    $info[$i]['state']=$state;
                    $shopping::where('id',$info[$i]['id'])->update(['state'=>$state]);
                }
                return json($info);
            }elseif (!empty($params['goodsid'])){
                if (!empty($params['state'])){
                    if ($params['state']==3){
                        $state = 1;
                    }else{
                        $state = 0;
                    }
                    $info =  $shopping::where([['username','=',$params['user']],['goodsid','=',$params['goodsid']]])->order('id','desc')->select();
                    $shopping::where('id',$info[0]['id'])->update(['state'=>$state]);
                    $info1 =  $shopping::where('username',$params['user'])->order('id','desc')->select();
                    return json($info1);
                }elseif (!empty($params['j'])){
                    $info =  $shopping::where([['username','=',$params['user']],['goodsid','=',$params['goodsid']]])->find();
                    $shopping::where('id',$info['id'])->update(['goodsnum'=>$params['j'],'total'=>$params['total']]);
                }elseif (!empty($params['jian'])){
                    $info =  $shopping::where([['username','=',$params['user']],['goodsid','=',$params['goodsid']]])->find();
                    $shopping::where('id',$info['id'])->update(['goodsnum'=>$params['jian'],'total'=>$params['total']]);
                }elseif (!empty($params['b'])){
                    $info =  $shopping::where([['username','=',$params['user']],['goodsid','=',$params['goodsid']]])->find();
                    $shopping::where('id',$info['id'])->update(['goodsnum'=>$params['b'],'total'=>$params['total']]);
                }elseif (!empty($params['del'])){
                    $info =  $shopping::where([['username','=',$params['user']],['goodsid','=',$params['goodsid']]])->find();
                    $shopping::where('id','=',$info['id'])->delete();
                    $info1 = $shopping::where('username',$params['user'])->order('id','desc')->select();
                    return json($info1);
                }
            }else{
                $info =  $shopping::where('username',$params['user'])->order('id','desc')->select();
                if ($info){
                    return json($info);
                }

            }
        }elseif (!empty($params['username'])){
            $peopleinfo=model('Peopleinfo');
            if(!empty($params['tian'])){
                //添加地址
                $inf = $peopleinfo::where(['username'=>$params['username'],'flag'=>1])->find();
                $info = [
                    'username'=>$params['username'],
                    'name'=>$params['name'],
                    'address'=>$params['address'],
                    'phone'=>$params['phone'],
                ];
                if ($inf){
                    $peopleinfo->save($info);
                }else{
                    $info['flag']=1;
                    $peopleinfo->save($info);
                }
                $info=$peopleinfo::where('username',$params['username'])->order('id','desc')->select();
                foreach ($info as $k=>$v){
                    if ($v['flag']==0){
                        $info[$k]['flag']=false;
                    }else{
                        $info[$k]['flag']=true;
                    }
                }
                return json($info);
            }elseif (!empty($params['xiu'])){
                $info1 = [
                    'name'=>$params['name'],
                    'address'=>$params['address'],
                    'phone'=>$params['phone'],
                    'id'=>$params['id1']
                ];
                $peopleinfo::update($info1);
                $info=$peopleinfo::where('username',$params['username'])->order('id','desc')->select();
                foreach ($info as $k=>$v){
                    if ($v['flag']==0){
                        $info[$k]['flag']=false;
                    }else{
                        $info[$k]['flag']=true;
                    }
                }
                return json($info);
            }elseif (!empty($params['shan'])){
                //删除地址
                $index='';
                $info22=$peopleinfo::where('username',$params['username'])->order('id','desc')->select()->toArray();
                foreach ($info22 as $k=>$v){
                    if ($v['id']==$params['id2']){
                        $index=$k;
                        break;
                    }
                }
                $peopleinfo::destroy($params['id2']);
                $info=$peopleinfo::where('username',$params['username'])->order('id','desc')->select();
                if($index==count($info22)-1){
                    $info[$index-1]['flag']=1;
                    $peopleinfo::update(['id'=>$info[$index-1]['id'],'flag'=>1]);
                }else{
                    $info[$index]['flag']=1;
                    $peopleinfo::update(['id'=>$info[$index]['id'],'flag'=>1]);
                }
                foreach ($info as $k=>$v){
                    if ($v['flag']==0){
                        $info[$k]['flag']=false;
                    }else{
                        $info[$k]['flag']=true;
                    }
                }
                return json($info);
            }elseif (!empty($params['id'])){
                //设置默认地址
                $info = $peopleinfo::where(['flag'=>1,'username'=>$params['username']])->find();
                if ($info){
                    $peopleinfo::update(['id'=>$info['id'],'flag'=>0]);
                }
                $peopleinfo::update(['id'=>$params['id'],'flag'=>1]);
                $info=$peopleinfo::where('username',$params['username'])->order('id','desc')->select();
                foreach ($info as $k=>$v){
                    if ($v['flag']==0){
                        $info[$k]['flag']=false;
                    }else{
                        $info[$k]['flag']=true;
                    }
                }
                return json($info);
            }
        }elseif (!empty($params['u'])){
            $peopleinfo=model('Peopleinfo');
            if(!empty($params['yi'])){
               $info=$peopleinfo::where(['username'=>$params['u'],'flag'=>1])->find();
               return json($info);
            }else{
                $info = $peopleinfo::where('username',$params['u'])->order('id','desc')->select();
                foreach ($info as $k=>$v){
                    if ($v['flag']==0){
                        $info[$k]['flag']=false;
                    }else{
                        $info[$k]['flag']=true;
                    }
                }
                return  json($info);
            }
        }


    }
    //加载提交订单页面
    public function tijiao(){
        $params = $this->request->param();
        if (!empty($params['id'])){
            $goods = model('Goods');
            $info = $goods::where('id',$params['id'])->find();
            return json($info);
        }elseif (!empty($params['user'])){
            $shopping = model('Shopping');
            $peopleinfo = model('Peopleinfo');
            $info1=$peopleinfo::where(['username'=>$params['user'],'flag'=>1])->find();
            $info = $shopping::where(['username'=>$params['user'],'state'=>1])->order('id','desc')->select();
            $arr=[
              'dizhi'=>$info1,
              'goods'=>$info
            ];
                return json($arr);
        }

    }
    //提交订单至数据库生成订单号
    //添加评论
    public function order(){
        $params = $this->request->param();
        $files = $this->request->file();
        $order = model('Order');
        //订单号
        $osn = date("ymdHis") . str_pad(mt_rand(1, 9999), 4, '0', STR_PAD_LEFT);
        if (!empty($params['type'])){//type说明未付款
            if(!empty($params['flag'])){//flag说明一定是一种商品
                $goodsid = $params['goodsid'];
                $goods = model('Goods');
                $expiration = strtotime($params['time'])+86400;
                $expiration = date("Y-m-d H:i:s",$expiration);
                $info = $goods::where('id',$goodsid)->find();
                $man=$info['goodsman'];
                $arr= [
                    'comstate'=>0,
                    'goodsman'=>$man,
                    'expiration'=>$expiration,
                    'state'=>1,
                    'goodsid'=>$goodsid,
                    'statename'=>'待付款',
                    'goodsname'  =>$info['goodsname'],
                    'goodsprice'=>$info['goodsprice'],
                    'goodsimg'=>$info['goodsimg'],
                    'goodsnum'=>$params['goodsnum'],
                    'time'=>$params['time'],
                    'orderid'=>$osn,
                    'username'=>$params['user'],
                    'total'=>$info['goodsprice']*$params['goodsnum']
                ];
                $info1=$order->save($arr);
            }
            else{
                $shopping = model('Shopping');
                $info1 = $shopping::where(['username'=>$params['user'],'state'=>1])->order('id','desc')->select();
                $expiration = strtotime($params['time'])+86400;
                $expiration = date("Y-m-d H:i:s",$expiration);
                if (count($info1)==1) {
                    $goods = model('Goods');
                    $man = $goods::where('id',$info1[0]['goodsid'])->find();
                    $man1=$man['goodsman'];
                    $arr = [
                        'comstate'=>0,
                        'goodsman'=>$man1,
                        'state'=>1,
                        'goodsid'=>$man['id'],
                        'statename'=>'待付款',
                        'expiration'=>$expiration,
                        'goodsname' => $info1[0]['goodsname'],
                        'goodsprice' => $info1[0]['goodsprice'],
                        'goodsimg' => $info1[0]['goodsimg'],
                        'goodsnum' => $info1[0]['goodsnum'],
                        'time' => $params['time'],
                        'orderid' => $osn,
                        'username' => $params['user'],
                        'total' => $info1[0]['total']
                    ];
                    $info2 = $order->save($arr);
                    if ($info2){
                        $shopping::where(['username'=>$params['user'],'state'=>1])->delete();
                    }
                }else{
                    $nums = '';
                    $ids = '';
                    $img = '';
                    $name = '';
                    $total = 0;
                    $man='';
                    $num=0;
                    $com='';
                    $goodsid='';
                    $states='';
                    $goods=model('Goods');
                    foreach ($info1 as $key =>  $value){
                        $man1 = $goods::where('id',$value['goodsid'])->find();
                        $man.=$man1['goodsman'].',';
                        $com.='0'.',';
                        $states.='1'.',';
                        $goodsid.=$man1['id'].',';
                        $nums.=$value['goodsnum'].',';
                        $num+=$value['goodsnum'];
                        $ids.=$value['goodsprice'].',';
                        $img.=$value['goodsimg'].',';
                        $name.=$value['goodsname'].',';
                        $total+=(int)($value['goodsnum'])*(int)($value['goodsprice']);
                    }
                    $com=rtrim($com,',');
                    $states=rtrim($states,',');
                    $goodsid = rtrim($goodsid,',');
                    $man = rtrim($man,',');
                    $nums = rtrim($nums,',');
                    $ids = rtrim($ids,',');
                    $img = rtrim($img,',');
                    $name = rtrim($name,',');
                    $expiration = strtotime($params['time'])+86400;
                    $expiration = date("Y-m-d H:i:s",$expiration);
                    $arr=[
                        'comstate'=>$com,
                        'goodsid'=>$goodsid,
                        'goodsman'=>$man,
                        'state'=>1,
                        'expiration'=>$expiration,
                        'states'=>$states,
                        'statename'=>'待付款',
                        'orderid'=>$osn,
                        'username'=>$params['user'],
                        'goodsnum'=>$num,
                        'time'=>$params['time'],
                        'type'=>0,
                        'total'=>$total,
                        'nums'=>$nums,
                        'prices'=>$ids,
                        'goodsimg'=>$img,
                        'goodsname'=>$name,
                    ];
                    $info = $order->save($arr);
                    if ($info){
                        $shopping::where(['username'=>$params['user'],'state'=>1])->delete();
                    }
                }
            }
        }elseif (!empty($params['degree'])){//前台评价按钮处理
            $comment = model('Comments');
            $comment->order($params,$files);
           $info = $order::where('orderid',$params['orderid'])->find();
          if ($info['type']){
              $order::update(['id'=>$info['id'],'comstate'=>1,'state'=>5,'statename'=>'已评价']);
              return json($order::where('orderid',$params['orderid'])->find());
          }else{
              $comsate=explode(',',$info['comstate']);
              $comsate[$params['comstate']]=1;
              $comsate=implode(',',$comsate);
              $states=explode(',',$info['states']);
              $states[$params['comstate']]=5;
              $states=implode(',',$states);
              $order::update(['id'=>$info['id'],'comstate'=>$comsate,'states'=>$states]);
              $info = $order::where('orderid',$params['orderid'])->find();
              $info['comstate']=explode(',',$info['comstate']);
              $info['states']=explode(',',$info['states']);
              $info['goodsimg']=explode(',',$info['goodsimg']);
              $info['goodsname']=explode(',',$info['goodsname']);
              $info['goodsid']=explode(',',$info['goodsid']);
              $info['goodsprice']=explode(',',$info['prices']);
              $info['goodsnum']=explode(',',$info['nums']);
              foreach ($info['comstate'] as $key =>$value){
                  if ($value==0){
                      return json($info);
                  }elseif (count($info['comstate'])==$key+1){
                      $order::update(['id'=>$info['id'],'state'=>5,'statename'=>'已评价']);
                      $info = $order::where('orderid',$params['orderid'])->find();
                      $info['comstate']=explode(',',$info['comstate']);
                      $info['states']=explode(',',$info['states']);
                      $info['goodsimg']=explode(',',$info['goodsimg']);
                      $info['goodsname']=explode(',',$info['goodsname']);
                      $info['goodsid']=explode(',',$info['goodsid']);
                      $info['goodsprice']=explode(',',$info['prices']);
                      $info['goodsnum']=explode(',',$info['nums']);
                      return json($info);
                  }
              }
          }
        }elseif (!empty($params['geng'])){//前台立即付款处理
            $info = $order::where('id',$params['id'])->find()->toarray();
            if($info['type']==0){//多商品种类订单
                $info['states']=explode(',',$info['states']);
                foreach ($info['states'] as $k=> $v){
                    $info['states'][$k]=2;
                }
                $info['states']=implode(',',$info['states']);
                $order::update(['id'=>$params['id'],'state'=>2,'statename'=>'待发货','states'=>$info['states'],'time'=>$params['time'],'expiration'=>null]);
            }else{
                $order::update(['id'=>$params['id'],'state'=>2,'statename'=>'待发货','time'=>$params['time'],'expiration'=>null]);
            }
        }else{
            if(!empty($params['flag'])){//
                $goodsid = $params['goodsid'];
                $goods = model('Goods');
                $info = $goods::where('id',$goodsid)->find();
                $man1=$info['goodsman'];
                $arr= [
                    'comstate'=>0,
                    'goodsid'=>$goodsid,
                    'goodsman'=>$man1,
                    'state'=>2,
                    'goodsname'  =>$info['goodsname'],
                    'goodsprice'=>$info['goodsprice'],
                    'goodsimg'=>$info['goodsimg'],
                    'goodsnum'=>$params['goodsnum'],
                    'time'=>$params['time'],
                    'orderid'=>$osn,
                    'username'=>$params['user'],
                    'total'=>$info['goodsprice']*$params['goodsnum']
                ];
                $info1=$order->save($arr);
                return json('成功');
            }else{
                $shopping = model('Shopping');
                $info1 = $shopping::where(['username'=>$params['user'],'state'=>1])->order('id','desc')->select();
                if (count($info1)==1) {
                    $goods = model('Goods');
                    $man = $goods::where('id',$info1[0]['goodsid'])->find();
                    $man1=$man['goodsman'];
                    $arr = [
                        'comstate'=>0,
                        'state'=>2,
                        'goodsid'=>$man['id'],
                        'goodsman'=>$man1,
                        'goodsname' => $info1[0]['goodsname'],
                        'goodsprice' => $info1[0]['goodsprice'],
                        'goodsimg' => $info1[0]['goodsimg'],
                        'goodsnum' => $info1[0]['goodsnum'],
                        'time' => $params['time'],
                        'orderid' => $osn,
                        'username' => $params['user'],
                        'total' => $info1[0]['total']
                    ];
                    $info2 = $order->save($arr);
                    if ($info2){
                        $shopping::where(['username'=>$params['user'],'state'=>1])->delete();
                    }
                }else{
                    $nums = '';
                    $ids = '';
                    $img = '';
                    $name = '';
                    $total = 0;
                    $num=0;
                    $man='';
                    $goodsid='';
                    $com='';
                    $states='';
                    $goods=model('Goods');
                    foreach ($info1 as $key =>  $value){
                        $man1=$goods::where('id',$value['goodsid'])->find();
                        $man.=$man1['goodsman'].',';
                        $goodsid.=$man1['id'].',';
                        $nums.=$value['goodsnum'].',';
                        $num+=$value['goodsnum'];
                        $com.='0'.',';
                        $states.='2'.',';
                        $ids.=$value['goodsprice'].',';
                        $img.=$value['goodsimg'].',';
                        $name.=$value['goodsname'].',';
                        $total+=(int)($value['goodsnum'])*(int)($value['goodsprice']);
                    }
                    $com=rtrim($com,',');
                    $states=rtrim($states,',');
                    $goodsid = rtrim($goodsid,',');
                    $man = rtrim($man,',');
                    $nums = rtrim($nums,',');
                    $ids = rtrim($ids,',');
                    $img = rtrim($img,',');
                    $name = rtrim($name,',');
                    $arr=[
                        'comstate'=>$com,
                        'goodsid'=>$goodsid,
                        'goodsman'=>$man,
                        'orderid'=>$osn,
                        'username'=>$params['user'],
                        'goodsnum'=>$num,
                        'time'=>$params['time'],
                        'type'=>0,
                        'state'=>2,
                        'states'=>$states,
                        'total'=>$total,
                        'nums'=>$nums,
                        'prices'=>$ids,
                        'goodsimg'=>$img,
                        'goodsname'=>$name,
                    ];
                    $info = $order->save($arr);
                    if ($info){
                        $shopping::where(['username'=>$params['user'],'state'=>1])->delete();
                    }
                }
            }
        }
    }
//    获取订单表数据
    public function getorder(){
        $order = model('Order');
        $params = $this->request->param();
        $nums=0;
        $status='';
        if (!empty($params['user'])){//展示前台订单
            $info = $order->where('username',$params['user'])->order('id','desc')->select();
            foreach ($info as $key =>$value){
                if(!$value['type']){
                    $nums=0;
                    $value['states']=explode(',',$value['states']);
                    $value['goodsid']=explode(',',$value['goodsid']);
                    $value['comstate']=explode(',',$value['comstate']);
                    $value['nums']=explode(',',$value['nums']);
                    $value['goodsname']=explode(',',$value['goodsname']);
                    $value['goodsprice']=explode(',',$value['goodsprice']);
                    $value['goodsimg']=explode(',',$value['goodsimg']);
                    foreach ($value['nums'] as $k => $v){
                        $nums+=(int)$v;
                    }
                    $value['num']=$nums;
                }
            }
            return json($info);
        }elseif (!empty($params['manager'])){//展示后台订单
            $info = $order::wherelike('goodsman','%'.$params['manager'].'%')->order('id','desc')->select()->toArray();
            $sum = '';
            foreach ($info as $key =>$value){
                if (!$value['type']){//说明为多商品
                    $info[$key]['states'] = explode(',',$value['states']);
                    $info[$key]['goodsman'] = explode(',',$value['goodsman']);
                    $info[$key]['goodsname'] = explode(',',$value['goodsname']);
                    $info[$key]['goodsimg'] = explode(',',$value['goodsimg']);
                    $info[$key]['prices'] = explode(',',$value['prices']);
                    $info[$key]['nums'] = explode(',',$value['nums']);
                    foreach ($info[$key]['goodsman'] as $k => $v){
                        if ($v!=$params['manager']){
                            array_splice($info[$key]['goodsname'],$k,1,8);
                        }
                    }
                    $i = array_search(8,$info[$key]['goodsname']);
                    while (is_numeric($i)){
                        array_splice($info[$key]['states'],$i,1);
                        array_splice($info[$key]['goodsimg'],$i,1);
                        array_splice($info[$key]['prices'],$i,1);
                        array_splice($info[$key]['nums'],$i,1);
                        array_splice($info[$key]['goodsname'],$i,1);
                        array_splice($info[$key]['goodsman'],$i,1);
                        $i = array_search(8,$info[$key]['goodsname']);
                    }
                    $info[$key]['goodsman'] = $params['manager'];
                    $info[$key]['state']=$info[$key]['states'][0];

                }
            }
            return  json($info);
        }elseif (!empty($params['id'])) {
            if (!empty($params['que'])) {//前台确认收货
                $info = $order::where('id', $params['id'])->find()->toarray();
                if ($info['type'] == 0) {//如果为多种商品的订单
                    $info['states'] = explode(',', $info['states']);
                    foreach ($info['states'] as $key => $value) {
                        $info['states'][$key] = 4;
                    }
                    $info['states'] = implode(',', $info['states']);
                    $order::update(['id' => $info['id'], 'states' => $info['states'], 'state' => 4, 'statename' => '待评价']);
                } else {
                    $order::update(['id' => $info['id'], 'state' => 4, 'statename' => '待评价']);
                }
            } elseif (!empty($params['fa'])) {//后台确认发货
                $info = $order::where('id', $params['id'])->find()->toarray();
                if ($info['type']) {//如果为单商品订单
                    $order::update(['id' => $info['id'], 'state' => 3, 'statename' => '待收货']);
                } else {
                    $info['states'] = explode(',', $info['states']);
                    $info['goodsman'] = explode(',', $info['goodsman']);
                    foreach ($info['states'] as $key => $value) {
                        if ($info['goodsman'][$key] == $params['fa']) {//卖家与登陆卖家名字相同时states为2
                            $info['states'][$key]=3;
                        }
                    }

                    foreach ($info['states'] as $key => $value) {
                        if ($info['states'][$key]==2) {
                            $info['states'] = implode(',', $info['states']);
                            $order::update(['id' => $info['id'], 'states' => $info['states'], 'state' => 2, 'statename' => '待发货']);
                            break;
                        }elseif(count($info['states'])==$key+1){//当全部为3时，改变状态并且更新数据
                            $info['states'] = implode(',', $info['states']);
                            $order::update(['id' => $info['id'], 'states' => $info['states'], 'state' => 3, 'statename' => '待收货']);
                        }
                    }

                }
            }


        }
    }
    //取消订单功能
    public function quxiao(){
        $params = $this->request->param();
        $order = model('Order');
        $people = model('Peopleinfo');
        if (!empty($params['user'])){
            if (!empty($params['id'])){
                if (!empty($params['s'])){
                    $order::destroy($params['id']);
                }else{
                    $info = $order::where('id',$params['id'])->find();
                    $info2 = $people::where('username',$params['user'])->find();
                    if (!$info['type']){
                            $nums=0;
                            $info['states']=explode(',',$info['states']);
                            $info['goodsnum']=explode(',',$info['nums']);
                            $info['goodsname']=explode(',',$info['goodsname']);
                            $info['goodsprice']=explode(',',$info['prices']);
                            $info['goodsimg']=explode(',',$info['goodsimg']);
                            $info['goodsid']=explode(',',$info['goodsid']);
                            foreach ($info['goodsnum'] as $k => $v){
                                $nums+=(int)$v;
                            }
                            $info['num']=$nums;
                        }
                    $info3 =[
                    'user'=>$info2,
                    'goods'=>$info
                    ];
                    return json($info3);
                }
            }
        }elseif (!empty($params['id1'])){//单商品全数量退款
            if (!empty($params['duo'])){
                $i=$params['i'];
                $total=0;
                $nums=0;
                $info =  $order::where('id',$params['id1'])->find()->toarray();
                foreach ( $info as $k=> $item) {
                    if(strstr($item, ',')){
                        $info[$k]=explode(',',$item);
                    }
                }
                array_splice($info['nums'],$i,1,$info['nums'][$i]-$params['num']);
                if($info['nums'][$i]==0){
                    array_splice($info['states'],$i,1,6);
                }
                $info['reback']+=$params['num'];
                $info['rebacks']+=$info['prices'][$i]*$params['num'];
                foreach ($info['states'] as $k=>$v){
                    if ($v!=6){
                        break;
                    }else if(count($info['states'])==$k+1){
                        $info['state']=6;
                        $info['statename']='交易失败';
                    }
                }
                foreach ( $info as $k=> $item) {
                    if(is_array($item)){
                       $info[$k]=implode(',',$item);
                    }
                }
                $order::update($info);
                $info =  $order::where('id',$params['id1'])->find();
                $nums=0;
                if ($info['type']!=1){
                    $info['states']=explode(',',$info['states']);
                    $info['goodsnum']=explode(',',$info['nums']);
                    $info['goodsname']=explode(',',$info['goodsname']);
                    $info['goodsprice']=explode(',',$info['prices']);
                    $info['goodsimg']=explode(',',$info['goodsimg']);
                    foreach ( $info['goodsnum'] as $k=>$v){
                        $nums+=(int)$v;
                    }
                    $info['num']=$nums;
                }
                return json($info);
            }else{
                $info = $order::where('id',$params['id1'])->find();
                $nums=$info['goodsnum']-$params['num'];
                $info['goodsnum']=$nums;
                $info['reback']+=$params['num'];
                if ($info['goodsnum']==0){
                    $info['state']==6;
                    $info['statename']='交易失败';
                    $order::update(['id'=>$params['id1'],'reback'=>$info['reback'],'goodsnum'=>$nums,'state'=>6,'statename'=>'交易失败']);
                    $info=$order::where('id',$params['id1'])->find();
                    return json($info);
                }else{
                    $order::update(['id'=>$params['id1'],'reback'=>$info['reback'],'goodsnum'=>$nums]);
                    $info['nums']=explode(',',$info['nums']);
                    $info=$order::where('id',$params['id1'])->find();
                    return json($info);
                }
            }
        }elseif (!empty($params['id2'])){//一种商品部分退款
            $info = $order::where('id',$params['id2'])->find();
            $nums=$info['goodsnum']-$params['num'];
            $info['reback']+=$params['num'];
            $order::update(['id'=>$params['id2'],'reback'=>$info['reback'],'goodsnum'=>$nums]);
            return json( $info = $order::where('id',$params['id2'])->find());
        }
    }
    //收货功能
    public function shou(){
        $order=model('Order');
        $params=$this->request->param();
       $info = $order::where('id',$params['id'])->find()->toarray();
       if (!empty($params['duo'])){
           $info['states']=explode(',',$info['states']);
           $info['states'][$params['i']]=4;
           foreach ($info['states'] as $k =>$v){
               if ($v==3){
                   break;
               }elseif($k+1==count($info['states'])){
                   $info['state']=4;
                   $info['statename']='待评价';
               }
           }
           $info['states']=implode(',',$info['states']);
           $order::update($info);
           $info = $order::where('id',$params['id'])->find()->toarray();
           foreach ($info as $k=>$v){
               if (strstr($v,',')){
                   $info[$k]=explode(',',$info[$k]);
               }
           }
           $info['goodsnum']=$info['nums'];
           $info['goodsprice']=$info['prices'];
           if (!empty($params['user'])){
               $info1=$order::where('username',$params['user'])->order('id','desc')->select()->toArray();
               foreach ($info1 as $k=>$v){
                   foreach ($v as $key=>$value){
                       if (strstr($value,',')){
                           $info1[$k][$key]=explode(',',$v[$key]);
                       }
                   }
                   $num=0;
                   if ($v['type']==0){
                       $info1[$k]['goodsnum']=$info1[$k]['nums'];
                       $info1[$k]['goodsprice']=$info1[$k]['prices'];
                       foreach ($info1[$k]['nums'] as $kk=> $vl){
                           $num+=(int)$vl;
                       }
                       $info1[$k]['num']=$num;
                   }
               }
               $arr=[
                   'bu'=>$info,
                   'quan'=>$info1
               ];
               return json($arr);
           }else{
               return json($info);
           }
       }else{
           $info['state']=4;
           $info['statename']='待评价';
           $order::update($info);
           foreach ($info as $k=>$v){
               if (strstr($v,',')){
                   $info[$k]=explode(',',$info[$k]);
               }
           }
           $info['goodsnum']=$info['nums'];
           $info['goodsprice']=$info['prices'];
          return json($order::where('id',$params['id'])->find());

       }
    }

}