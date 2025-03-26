## 一、环境配置

- 安装salesforce CLI

- 安装vs插件salesforce Extensions for VS code

- node.js环境安装

  ```
  npm install sfdx-cli --global
  ```

安装vs code salesforce的插件

​     Salesforce Extension Pack

参考网站

​      [lightning-card - documentation - Salesforce Lightning Component Library](https://developer.salesforce.com/docs/component-library/bundle/lightning-card/documentation)



### 连接salesfoce环境

> Authorise an Org  认证
>
> - 设置默认浏览器
> - 在该浏览器中登录到salesforce

### salesforce部署失败

> - 开发文件文件未保存
> - 代理
> - node.js

### 安装差分工具

```
sfdx plugins:install @salesforce/sfdx-diff
```



```html
<!--子组件html-->
<template>
  <div class="view">{itemName}<div>
</template>
    
<!--父组件html-->
<template>
  <div>{childApiValue}</div>
  <lightint-button variant=variant label="Get Value Child" onclick={getChildApi}>
    <!--以标签的形式将值传给子组件-->
    <c-api-item-lwc item-name="test publice property"><c-api-item-lwc>
</template>
```

### 在LWC组件中引入静态资源



### 上传静态资源到salesforce

  **設定** `=>` **カスタムコード `=>`   静的リソース　`=>`  新規** 

- 引入

  ```js
  import icon from '@salesforce/resourceUrl/SB_Icon';
  ```

- 使用

  ```js
  icon+'/SB_forTestNoImage.png'
  ```

## 2.LWC

### 1.组件互动

#### 1.1子组件js获取父组件的值

```js
export default class ApiItemlwc extends LightintElement{
@Api itemName
}
```

父组件js获取子组件值

```js
export default class ApiparentLwc extends LightintElement{
childApiValue;
getChildApi(){
  this.childApiValue=this.template.querySelector('c-api-item-lwc').itemName
}
}
```



#### 1.2组件配置

- -meta.xml

```xml
<!--公开组件--> 
<isExposed>true</isExposed>
<!--公开范围-->
    <targets>
        <target>lightningCommunity__Page</target>
        <target>lightningCommunity__Default</target>
    </targets>
<!--配置组件属性：用于在网页上对组件进行传值等操作-->
    <targetConfigs>
        <targetConfig targets="lightningCommunity__Default">
            <property name="pageTitle" label="pageTitle" type="String" />
            <property name="menuId" label="menuId" type="String" />
            <property name="path" label="path" type="String" />
        </targetConfig>
    </targetConfigs>
```

:cactus:自动取值

> {!recordId}



### 2.**及时响应**

1.传统的数据类型不需要声明@track即可及时响应

例如：`String` `int` 



2.@track声明用于<u>数组</u>，<u>对象</u>等的及时响应

例如：adress={province:"",city:""}



### 3.生命周期

- constructor();

​      用于lwc组件被实例化的时候

- connectedCallback()

​      用于lwc组件被渲染到DOM上的时候

- disconnectedCallback()

​     用于lwc组件被移除DOM的时候

- renderedCallback()

​     只执行一代码



### 4.@wire

```js
@wire(getAccountByName,{accountName:'$accName'})
getData(data,error){
 if(data){
 this.name=data.name
}else if(error  ){
   console.log(error)
}
}
```



### 5.组件传值



子组件传父组件   

子组件

```js
creatEvent(){
     const event=CustomEvent('childevent',{
         detail:{'para1':'test1',para2':'test2'}
    });
this.dispatchEvent(event);
}
```

```xml
<template>
   <div></div>
   <lightning-button class="slds-button slds-button_brand" label="create event" onclick={createEvent}></lightning-button>
</template>
```

父组件

```js
para1;
para2;
listenEvent(event){
this.para1=event.datail.para1;
this.para2=event.detail.para2
}
```

```html
<template>
  <div>parent lwc</div>
  <div>{para2}</div>
  <div>{para2}</div>
 <c-child-lwc onchildEvent={listenEvent}></c-child-lwc>
</template>
```

### 6.获取组件



```html
<p>テスト１</p>
<p data-id="test">テスト２</p>
<p class="classTest">テスト３</p>
<p class="classTest">テスト４</p>
<lightning-input onclick={comfirm}></lightning-input>
```

```js
const elem=this.template.querySelector('p').outerText;
//取第一个p元素
const elem=this.template.querySelector('p[data-id=\'test\']').outerText;
//取特定元素
const elem=this.template.querySelector('.classTest').outerText;
//通过css查询元素
const elem=this.template.querySelectAll('p').outerText;
//通过元素名或者css
```



### 7.页面迁移



![](https://i.loli.net/2021/08/10/SgqFc9jDNYrnwvE.png)

---

![](https://i.loli.net/2021/08/10/udZFWTefmLzVagw.png)

---

```js
import {NavigationMixin} from "lightning/navigation";
extends NavigationMixin(LightningElement) 
 this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'detailPages__c'
            }
        });
//传值
 this[NavigationMixin.Navigate]({
                type: 'comm__namedPage',
                attributes: {
                    name: 'custom_firmware_detail__c'
                },
                state: {
                    breadcrumbs: JSON.stringify(this.breadcrumbsList)
                }
            });
```

---

```js
 @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.lengthSize = JSON.parse(currentPageReference.state.item);
        this.seihinId = this.lengthSize[this.lengthSize.length-1].Id;

  @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.lengthSize =JSON.parse(currentPageReference.state.item)
        this.seihinListPageId=this.lengthSize[this.lengthSize.length-1].Id;
      
    }
```

---



```js
     this[NavigationMixin.Navigate]({
                type: 'comm__namedPage',
                attributes: {
                    name: 'brandInfoChild__c'
                },
                state: {
                    c__param: JSON.stringify([{ path: 'o1' }, { path: '02' }, { path: '01' }])
                }
            })
```

---

```js
import { CurrentPageReference, NavigationMixin } from 'lightning/navigation';
```

#### 7.1.配置自定义搜索跳转详情页

```js
this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: this.recordId,
        objectApiName: "SB_OshiraseInfo__c",
        actionName: "view"
      },
      state: {
        breadcrumbs: JSON.stringify()
      }
    });
//组件配置
 <targetConfigs>
        <targetConfig targets="lightningCommunity__Default">
            <property name="recordId" label="recordId" type="String" />
        </targetConfig>
 </targetConfigs>
//页面配置
//{!recordId}
```

```xml
 <targetConfigs>
        <targetConfig targets="lightningCommunity__Default">
            <property name="pageTitle" label="pageTitle" type="String" />
            <property name="menuId" label="menuId" type="String" />
            <property name="path" label="path" type="String" />
        </targetConfig>
    </targetConfigs>
```

---

#### 7.2打开URL并跳转空白页

```js
 this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: event.target.dataset.file
                }
            });
```

---

#### 7.3.跳转对象列表页

```js
 this[NavigationMixin.Navigate]({
            type: "standard__objectPage",
            attributes: {
              objectApiName: "MitumoriIrai__c",
              actionName: "list"
            },
            state:''//检索条件
    })
```

#### 7.4.生成url地址

```js
@track recordPageUrl;
    connectedCallback() {
        // Generate a URL to a User record page
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '005B0000001ptf1IAE',
                actionName: 'view',
            },
        }).then((url) => {
            this.recordPageUrl = url;
        });
    }
//同理可以运用到其他种类的页面url获取
```



### 7.Action



参考网站

[Salesforce LWC学习(三十六) Quick Action 支持选择 LWC了 - 云+社区 - 腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1875203)





### 8.取得選択リスト

js

```js
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import Product__c from '@salesforce/schema/Product__c';
import PRODUCT_DOC from '@salesforce/schema/Product__c.DocumentCode1__c';
 
 @wire(getObjectInfo, { objectApiName: Product__c })
    productInfo;
    //規格リスト取得
 @wire(getPicklistValues, { recordTypeId: '$productInfo.data.defaultRecordTypeId', fieldApiName: PRODUCT_DOC })
    standardList;
    //資料コード1リスト取得
```

### 9.Action



meta.xml

```xml
  <isExposed>true</isExposed>
    <targets>
        <target>lightning__RecordAction</target>
    </targets>
    <targetConfigs>
        <targetConfig targets="lightning__RecordAction">
           <actionType>ScreenAction</actionType>
        </targetConfig>
    </targetConfigs>
```

html

```xml
<lightning-quick-action-panel header="SCIMへ連携(取得)">
        <p if:false={serverError}>このアカウントの情報をSCIMから取得しますか</p>
        <lightning-formatted-rich-text if:true={serverError} value={serverError}></lightning-formatted-rich-text>
        <div slot="footer">
            <lightning-button variant="neutral" label="キャンセル" onclick={cansel}></lightning-button>
            <lightning-button variant="brand" label="確定" onclick={postToNewScim} class="slds-m-left_x-small">
            </lightning-button>
        </div>
    </lightning-quick-action-panel>
```

js

```js
import { api, LightningElement, track } from 'lwc';
import getUser from '@salesforce/apex/SB_GetUserFromScimController.getTheUser';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class SbUniteToScimGet extends LightningElement {
    @api recordId;
    @track serverError;
    /**
     * SCIMへ連携(取得)
     * @param {*} event
     */
    async postToNewScim(event) {
        event.preventDefault();
        const result = await getUser({ userId: this.recordId });
        this.serverError = result.messageServer;
        if (result.status === 'success') {
            console.log(result.status);
            const evt = new ShowToastEvent({
                title: 'SCIMへ連携(取得)成功しました',
                message: '取得したId:' + result.message,
                variant: 'success'
            });
            this.dispatchEvent(evt);
        }
        if (result.status === 'failed') {
            const evt = new ShowToastEvent({
                title: 'SCIMへ連携(取得)失敗しました',
                message: 'エラーメッセージ:' + result.message ?? '取得失敗しました',
                variant: 'error'
            });
            this.dispatchEvent(evt);
        }
        console.log(this.recordId);
        console.log(result);
        if(!this.serverError){
            this.dispatchEvent(new CloseActionScreenEvent());
        }
        if(result.status === 'success'){
            location.reload();
        }
    }

    /**
     * SCIMへ連携(取得)キャンセル
     * @param {*} e
     */
    cansel(e) {
        e.preventDefault();
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}
```



## 二.参考网站

###   1.salesforce数据库操作

- https://www.cnblogs.com/chengcheng0148/p/salesforce_database_query_introduction.html

  

### 2.Apex教程网站

- [Apex - 数据类型_w3cschool](https://www.w3cschool.cn/apex/apex_data_types.html)

- https://developer.salesforce.com/docs/atlas.ja-jp.apexcode.meta/apexcode/apex_dynamic_soql.htm

  

### 3.LWC原生标签参考网站

- https://developer.salesforce.com/docs/component-library/bundle/lightning-card/documentation

- lightning-record-form:

    https://www.cnblogs.com/zero-zyq/p/11380449.html

  [Salesforce学习 Lwc（一） lightning-record-edit-form标签 - 云+社区 - 腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1758372)

## 三、SOQL

### 1.SQOL参考网站

https://www.cnblogs.com/zero-zyq/p/5283611.html



参考网站

  [salesforce 零基础开发入门学习（三）sObject简单介绍以及简单DML操作（SOQL） - zero.zhang - 博客园 (cnblogs.com)](https://www.cnblogs.com/zero-zyq/p/5283611.html)





### 2.Data type

```
一）Data type

当数据表创建表的列时，会选择Data Type,不同的Data Type在页面处理以及数据插入时会有不同的处理。而且不同的字段会有其相对应的数据类型与之对应。

1.Auto Number:系统生成的序列号，通过自身定义的形式显示，为每条新纪录自动递增数；

2Formula：声明一个计算式，功能很强大，以后会单独篇章讲解formula用法；

3.Lookup Relationship:创建链接一个对象和另一个对象的关系，创建关系后，通过一个对象可以访问另一个对象的内容信息；

4.Master-Detail Relationship:创建一个特殊的父子关系（主从关系），和lookup Relationship 的相同与差异在下面介绍；

5.External Lookup Relationship:创建一个对象和另一个额外对象的关系。其中这个对象的数据存储在额外对象的数据源中；

6.Checkbox：声明一个布尔类型；

7.Currency:声明一个货币类型；

8.Date：声明一个Date类型，用户在前台绑定后可以直接使用Date类型相应的控件；

9.Date/Time：声明一个Date和Time类型，用户选择日期后，日期和当前时间便赋值到输入域；

10.Email：声明一个Email类型；

11.Geolocation:声明一个位置的类型，此类型包含经纬度信息；

12.Number:允许输入任何的数字，如果输入的全是0则全部移除；

13.Percent:声明一个百分比类型；

14.Phone：声明一个手机号码类型，输入的内容自动转换成此类型；

15.Picklist:声明一个列表类型，类似于HTML中的<select><option></option></select>关系，下面会有例子讲解；

16.Picklist（Multi-Select）:声明一个列表类型，区别上面的为允许多选；

17.Text:声明一个字符串类型，最大长度为255；

18.Text Area:和Text类型相似，区别为内容可以换行；

19.Text Area(Long):和Text Area相似，最大长度为131072；

20.Text Area(Rich):富输入框，可以存储图片等；

21.Text(Encrypted):可以加密的形式存储；

22.URL：声明一个URL类型。
```



### 3.关键字



#### 3.1. SELECT

##### 3.1.1 [...field]需要查询的字段,其中Id为默认查询字段，即便在查询字段中也会被返回查询结果

- [...field]

  ```sql
  SELECT Id,Name FROM Acount
  ```

##### 3.1.2 FIELD(ALL) 查询所有字段

- FIELD(ALL) 

  ```sql
  SELECT FIELD(ALL) FROM Acount
  ```

  

##### 3.1.3 聚合函数

- COUNT(Id)

  ```
  List<AggregateResult> mdt = [SELECT count(Id) FROM User];
  #返回(AggregateResult:{expr0=476})
  ```

- COUNT()

  ```
  Integer ct = [SELECT COUNT() FROM User];
  ```

  

#### 3.2. INCLUDES

> salesforce中的 `選択リスト`会记录比较多的数据，有时候你要查的数据是某个值存在于多项选择列表中就需要筛选出来。如果你直接先把数据都查出来然后在for循环里面去进行判断筛选就会使程序性能降低，程序可读性变差。其实这种情况直接通过soql就能解决。如

### 　查询例句

```java
String queryString = 'select id,Account__r.Name,Phone__c,Account__r.Address__c,Phase__c,CreatedDate,DecorationAddress__c,LastModifiedDate,HostEmployee__c'
                                    +',Intention__c,Source__c,NoFollow_Day__c,ActiveStatus__c,Labels__c,Other_Labels__c,Renovation_District__c'
                                    +',Employee__r.Wechat_User__r.vlink__User_ID__c,Lead__c,Area__c'
                                    +' from Opportunity__c'
                                    +' where Employee__c in :rightEmpIds'
                                    +(Intention!='' ? (' And IntentionCode__c in '+('('+intentionStr+')')) : '')
                                    +(NoFollow_Day!=0 ? (' And OppNoFollow_Day__c <= ' + Integer.valueOf(NoFollow_Day)) : '')
                                    +(ActiveStatus!='' ? (' And ActiveStatus__c in '+('('+activeStatusStr+')')) : '')
                                    +(Labels!='' ? (' And Labels__c includes '+('('+labelsStr+')') ): '')
                                    +(customLabels!=null ? (' And Other_Labels__c like '+'\'%'+customLabels+'%\'') : '')
                                    +(startDate!=NULL ? (' And CreatedDate__c>='+startDate) : '')
                                    +(endDate!=NULL ? (' And CreatedDate__c<='+endDate) : '')
                                    +(Utils.isNull(searchInfo) ? '' : ' And('
                                    +' Account__r.Name like '+'\'%'+searchInfo+'%\''
                                    +' OR Phone__c like '+'\'%'+searchInfo+'%\''
                                    +')')
                                    +' Order by TaskPhaseCode__c ASC,createdDate desc' 
                                    +' limit 50000'
                                    ; 

```



### 5.Soql

参考网站

  [salesforce 零基础开发入门学习（三）sObject简单介绍以及简单DML操作（SOQL） - zero.zhang - 博客园 (cnblogs.com)](https://www.cnblogs.com/zero-zyq/p/5283611.html)

#### 5.1.salesforce原生对象

#### 	5.2.userRole

​	官方文档：

> ​			[UserRole | Salesforce Field Reference Guide | Salesforce Developers](https://developer.salesforce.com/docs/atlas.en-us.sfFieldRef.meta/sfFieldRef/salesforce_field_reference_UserRole.htm)







### 2.soql时间

|                     |                                                              |                                                              |
| ------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| YESTERDAY           | SELECT Id FROM Account WHERE CreatedDate = YESTERDAY         | **昨天：** 从前一天的 00:00:00 开始，持续 24 小时。          |
| TODAY               | SELECT Id FROM Account WHERE CreatedDate > TODAY             | **今天：**从当天的 00:00:00 开始，持续 24 小时。             |
| TOMORROW            | SELECT Id FROM Opportunity WHERE CloseDate = TOMORROW        | **明天：**从当天之后的 00:00:00 开始并持续 24 小时。         |
| LAST_WEEK           | SELECT Id FROM Account WHERE CreatedDate > LAST_WEEK         | **上周：**从最近一周的第一天之前的一周的第一天 00:00:00 开始， 持续整整 7 天。您的语言环境决定了一周的第一天。 |
| THIS_WEEK           | SELECT Id FROM Account WHERE CreatedDate < THIS_WEEK         | **本周：**从当天或之前一周的最近第一天的 00:00:00 开始，并持续 7 天。 您的语言环境决定了一周的第一天。 |
| NEXT_WEEK           | SELECT Id FROM Opportunity WHERE CloseDate = NEXT_WEEK       | **下周：**从当天后一周的最近第一天 00:00:00 开始，持续 7 天。 您的语言环境决定了一周的第一天。 |
| LAST_MONTH          | SELECT Id FROM Opportunity WHERE CloseDate > LAST_MONTH      | **上个月：**从当前日期前一个月的第一天 00:00:00 开始，并持续到该月的所有日子。 |
| THIS_MONTH          | SELECT Id FROM Account WHERE CreatedDate < THIS_MONTH        | **这个月：**从当前日期所在月份的第一天 00:00:00 开始，并持续到该月的所有日子。 |
| NEXT_MONTH          | SELECT Id FROM Opportunity WHERE CloseDate = NEXT_MONTH      | **下个月：**从当前日期所在月份的下一个月的第一天 00:00:00 开始， 并持续到该月的所有日子 |
| LAST_90_DAYS        | SELECT Id FROM Account WHERE CreatedDate = LAST_90_DAYS      | **90天：**从当天开始并持续到过去 90 天。 这包括当天，而不仅仅是前几天。所以它总共包括91天。 |
| NEXT_90_DAYS        | SELECT Id FROM Opportunity WHERE CloseDate > NEXT_90_DAYS    | **90天：**从第二天的 00:00:00 开始，并持续到接下来的 90 天。 |
| LAST_N_DAYS:n       | SELECT Id FROM Account WHERE CreatedDate = LAST_N_DAYS:365   | **N = 天：**对于提供的数字n，从当天开始并持续到过去n天。 这包括当天，而不仅仅是前几天。例如，LAST_N_DAYS:1包括昨天和今天。 |
| NEXT_N_DAYS:n       | SELECT Id FROM Opportunity WHERE CloseDate > NEXT_N_DAYS:15  | **N = 天：**对于提供的数字n，从第二天的 00:00:00 开始并持续接下来的n天。 这不包括当天。例如，NEXT_N_DAYS:1相当于明天. |
| NEXT_N_WEEKS:n      | SELECT Id FROM Opportunity WHERE CloseDate > NEXT_N_WEEKS:4  | **N = 周：**对于提供的数字n，从下周第一天的 00:00:00 开始，并持续接下来的n周。 |
| LAST_N_WEEKS:n      | SELECT Id FROM Account WHERE CreatedDate = LAST_N_WEEKS:52   | **N = 周：**对于提供的数字n，从前一周最后一天的 00:00:00 开始，并持续过去n周。 |
| NEXT_N_MONTHS:n     | SELECT Id FROM Opportunity WHERE CloseDate > NEXT_N_MONTHS:2 | **N = 月：**对于提供的数字n，从下个月第一天的 00:00:00 开始，并持续到接下来的n个月。 |
| LAST_N_MONTHS:n     | SELECT Id FROM Account WHERE CreatedDate = LAST_N_MONTHS:12  | **N = 月：**对于提供的数字n，从上个月最后一天的 00:00:00 开始，并持续过去n个月。 |
| THIS_QUARTER        | SELECT Id FROM Account WHERE CreatedDate = THIS_QUARTER      | **这个季度：**从当前季度的 00:00:00 开始，一直持续到当前季度末。 |
| LAST_QUARTER        | SELECT Id FROM Account WHERE CreatedDate > LAST_QUARTER      | **上个季度：**从上一季度的 00:00:00 开始，一直持续到该季度末。 |
| NEXT_QUARTER        | SELECT Id FROM Account WHERE CreatedDate < NEXT_QUARTER      | **下个季度：**从下一季度的 00:00:00 开始，一直持续到该季度末。 |
| NEXT_N_QUARTERS:n   | SELECT Id FROM Account WHERE CreatedDate < NEXT_N_QUARTERS:2 | **N = 季度：**从下个季度的 00:00:00 开始，一直持续到第n个季度末。 |
| LAST_N_QUARTERS:n   | SELECT Id FROM Account WHERE CreatedDate > LAST_N_QUARTERS:2 | **N = 季度：**从上一季度的00:00:00开始，一直持续到上一季度的结束。 |
| THIS_YEAR           | SELECT Id FROM Opportunity WHERE CloseDate = THIS_YEAR       | **今年：**从当年 1 月 1 日 00:00:00 开始，一直持续到当年 12 月 31 日结束。 |
| LAST_YEAR           | SELECT Id FROM Opportunity WHERE CloseDate > LAST_YEAR       | **去年：**从上一年的 1 月 1 日 00:00:00 开始，一直持续到当年的 12 月 31 日结束。 |
| NEXT_YEAR           | SELECT Id FROM Opportunity WHERE CloseDate < NEXT_YEAR       | **明年：**从次年 1 月 1 日 00:00:00 开始，一直持续到当年 12 月 31 日结束。 |
| NEXT_N_YEARS:n      | SELECT Id FROM Opportunity WHERE CloseDate < NEXT_N_YEARS:5  | **N = 年：**从次年的 1 月 1 日 00:00:00 开始，一直持续到第n年的 12 月 31 日结束。 |
| LAST_N_YEARS:n      | SELECT Id FROM Opportunity WHERE CloseDate > LAST_N_YEARS:5  | **N = 年：**从前一年的 1 月 1 日 00:00:00 开始，一直持续到前n年的 12 月 31 日结束。 |
| THIS_FISCAL_QUARTER | SELECT Id FROM Account WHERE CreatedDate = THIS_FISCAL_QUARTER | **当前财政季度：**从当前财政季度的第一天 00:00:00 开始，一直持续到财政季度的最后一天结束。 会计年度在“设置”的“会计年度”页面上定义。 |
| LAST_FISCAL_QUARTER | SELECT Id FROM Account WHERE CreatedDate > LAST_FISCAL_QUARTER | **上个财政季度：**从上一个财政季度的第一天的 00:00:00 开始，一直持续到该财政季度的最后一天结束。 会计年度在“设置”的“会计年度”页面上定义。 |





## 四、Apex



###     1.基本数据类型

- Integer, 
- Double,
- Long, 
- Date, 
- Datetime, 
- String,
-  ID,
- Boolean

### 2.其他数据类型

- Collections (Lists, Sets and Maps) (To be covered in Chapter 6) 集合（列表，集合和地图）（将在第6章中讨论）

- sObject

  ```
  //Declaring an sObject variable of type Account
  Account objAccount = new Account();
  
  //Assignment of values to fields of sObjects
  objAccount.Name = 'ABC Customer';
  objAccount.Description = 'Test Account';
  System.debug('objAccount variable value'+objAccount);
  
  //Declaring an sObject for custom object APEX_Invoice_c
  APEX_Customer_c objCustomer = new APEX_Customer_c();
  ```

### 3.Enums 枚举



```Apex
public enum Compounds {HCL, H2SO4, NACL, HG}
Compounds objC = Compounds.HCL;
```



- Classes, Objects and Interfaces (To be covered in Chapter 11, 12 and 13) 类，对象和接口（将在第11,12和13章中讨论）

### 4.日期

```Apex
Date date=Date.today();
Date date1=Date.newInstance(2017,7,1);
    system.debug('==日期=='+date1);
Date date2=Date.parse('2018/10/1');
  system.debug('==日期2=='+date2);
Integer months=date1.monthsBetween(date2);
system.debug('相差月份'+months);
Integer days=date1.daysBetween(date2);
 system.debug('相差日期'+days);
Boolean same=date1.isSameDay(date2);
system.debug('是否为同一天'+same);
```

```sql
#查询某一时间之间的数据将两个时间AND分开，并且只能字段在前
(ShiryoKanrenMoto__r.KeisaiShuryoBi__c  >= TODAY or ShiryoKanrenMoto__r.KeisaiShuryoBi__c = null) 
 AND (ShiryoKanrenMoto__r.KeisaiKaishiBi__c <= TODAY OR ShiryoKanrenMoto__r.KeisaiKaishiBi__c = null)
```



### 5.Apex 测试环境配置



.vscode `=>` setting.json



```json
{
  "search.exclude": {
  "**/node_modules": true,
  "**/bower_components": true,
  "**/.sfdx": true,
  },
  "salesforcedx-vscode-apex.java.home": "C:\\tools\\zulu11",//这行为你的java路径 要改成你自己的
  "salesforcedx-vscode-core.show-cli-success-msg": false,
  "salesforcedx-vscode-core.retrieve-test-code-coverage":true,
}

```

### 6.常用类的例子



```java
 @AuraEnabled(cacheable=true)
    public static List<String> getSentakuList(String tableApiName,String fieldName){
        List<Schema.PicklistEntry> allPicklistValuesByField;
        List<Schema.DescribeSobjectResult> objDescriptions = Schema.describeSObjects(new List<String>{tableApiName});
        Schema.SObjectField field = objDescriptions[0].fields.getMap().get(fieldName);
        Schema.DescribeFieldResult fieldDescribeResult = field.getDescribe();
        allPicklistValuesByField = fieldDescribeResult.getPicklistValues();
        List<String> optionValue2LabelMap = new List<String>();
         for(Schema.PicklistEntry entry : allPicklistValuesByField) {
                optionValue2LabelMap.add(entry.getLabel()+'+'+entry.getValue());
         }
         return optionValue2LabelMap;
    }
```

```java
// sObject types to describe
String[] types = new String[]{'Account','Merchandise__c'};

// Make the describe call
Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);

System.debug('Got describe information for ' + results.size() + ' sObjects.');

// For each returned result, get some info
for(Schema.DescribeSobjectResult res : results) {
    System.debug('sObject Label: ' + res.getLabel());
    System.debug('Number of fields: ' + res.fields.getMap().size());
    System.debug(res.isCustom() ? 'This is a custom object.' : 'This is a standard object.');
    // Get child relationships
    Schema.ChildRelationship[] rels = res.getChildRelationships();
    if (rels.size() > 0) {
        System.debug(res.getName() + ' has ' + rels.size() + ' child relationships.');
    }
}
```



### 7.常用查询语法



#### Switch When

Switch when语法介绍。为了减少if else的写法，增强程序可读性，可以使用switch when语法替代。示例如下。

```java
switch on i {
when 2 {
System.debug('when block 2');
}
when -3 {
System.debug('when block -3');
}
when else {
System.debug('default');
}
}
```

### 8.カスタム表示ラベル

　　　

![](https://i.loli.net/2021/08/10/6sYWiMXTc8dtvku.png)

---

**取得**

```Apex
String months=system.Label.Months;
system.debug('months'+months);
List<String> monthList=months.split(',');
system.debug('months'+monthList);    
```

```js
import monthLabel from @salesforce/label/namespace.label_name
```



### 9.カスタム設定

取得

```java
    /**
     * カスタム設定データ取得
     * @return SCIM_API__c
     */
    private static SCIM_API__c getScimSetting(){
        List<SCIM_API__c> mcs = SCIM_API__c.getall().values();
         return mcs[0];
    }
```

> **Visualforce**: {! $Label.Label_API_Name }
>
> **Lightning component**: {!$Label.c.Label_API_Name}*  (**Note**: there are dynamic methods, too.)
>
> **Apex:** String someLabel = System.Label.Label_API_Name;*

### 10.rollback

回滚

```java
Savepoint sp = DataBase.setSavepoint();
DataBase.rollback(sp);
```

### 11.SObject API



#### 	12.1.参考地址：

​			[SObject Class | Apex Reference Guide | Salesforce Developers](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_sobject.htm#apex_System_SObject_put)



#### 12.2.注意点：

​		（1）isSet(fieldName):当一个字段被赋值以后，无论后面该字段为null或者是空字符串，此方法返回值都为true,除非用clear()



### 13. orgin class

**1.参考地址：**

​			[Map Class | Apex Reference Guide | Salesforce Developers](https://developer.salesforce.com/docs/atlas.en-us.236.0.apexref.meta/apexref/apex_methods_system_map.htm#apex_System_Map_methods)





### 14.正規表現

[Pattern と Matcher の使用 | Apex 開発者ガイド | Salesforce Developers](https://developer.salesforce.com/docs/atlas.ja-jp.228.0.apexcode.meta/apexcode/apex_classes_pattern_and_matcher_using.htm)



例子：

```java
String a = 'staff_s12345678914';
pattern onePattern = pattern.compile('^[s][0-9]{11}$'); 
matcher oneMatcher = onePattern.matcher(a);
pattern twoPattern = pattern.compile('^(staff_s)[0-9]{11}$'); 
matcher twoMatcher = twoPattern.matcher(a);
if(oneMatcher.matches() || twoMatcher.matches()){
    system.debug('true');
}
```

#### 15.カスタムメターデータ

[【Salesforce】カスタムメタデータのはじめかた - Qiita](https://qiita.com/t_yano/items/2013270d8ef2b79a3c98)





## 六、测试类

### HttpCalloutMock测试

- ###### [http callout test class写法](https://www.cnblogs.com/zero-zyq/p/6574863.html)

  参考网站地址：

  >  [salesforce 零基础学习（六十八）http callout test class写法 - zero.zhang - 博客园 (cnblogs.com)](https://www.cnblogs.com/zero-zyq/p/6574863.html)

在项目中我们经常会用到通过http方式和其他系统交互，测试类简单编写方式如下：

> 1.新建一个mock类用以模仿与第三方服务器的交互
>
> ```java
> @istest
> global class SB_UniteToScimMock implements HttpCalloutMock {
>     /**
>      *  仮想インターフェース
>      */
>     global HTTPResponse respond(HttpRequest req) {
>         HttpResponse res = new HttpResponse();
>         res.setHeader('Content-Type', 'application/json');
>         if (req.getMethod() == 'POST') {
>             res.setBody('{"id": "8de045bc-2fb9-41e7-8100-e41ee08152d3"}');
>         }
>         if (req.getMethod() == 'PUT') {
>             res.setBody('{"id": "8de045bc-2fb9-41e7-8100-e41ee08152d3"}');
>         }
>         if (req.getMethod() == 'GET') {
>             res.setBody( '{"schemas": ["urn:ietf:params:scim:api:messages:2.0:Error"],"detail": "Not found.","status": 404}');
>         }
>         res.setStatusCode(200);
>         return res;
>     }
> }
> ```



> 2.测试类代码
>
> ```java
> @isTest
>     static void postUserTest() {
>         SB_UserInfoManagement__c user = [SELECT Id FROM SB_UserInfoManagement__c WHERE employeeNumber__c = '123'];
>         Test.startTest();
>         Test.setMock(HttpCalloutMock.class, new SB_UniteToScimMock());
>         SB_PostToScimController.postUser(user.Id);
>         Test.stopTest();
>     }
> ```
>





## 七、承認プロセス

### 承認プロセス設定



https://www.sunbridge.com/blog/tips/salesforce-approval-process/  

Salesforceの承認プロセス設定方法を解説｜自動化するメリットは？

## 八、バッチ

### 定时执行

参考网站：https://blog.csdn.net/wangyi9896/article/details/79567743

