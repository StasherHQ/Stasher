<?php
/**
 * Controller is the customized base controller class.
 * All controller classes for this application should extend from this base class.
 */
class Controller extends CController
{
	/**
	 * @var string the default layout for the controller view. Defaults to '//layouts/column1',
	 * meaning using a single column layout. See 'protected/views/layouts/column1.php'.
	 */
	public $layout='//layouts/column1';
	/**
	 * @var array context menu items. This property will be assigned to {@link CMenu::items}.
	 */
	public $menu=array();
	/**
	 * @var array the breadcrumbs of the current page. The value of this property will
	 * be assigned to {@link CBreadcrumbs::links}. Please refer to {@link CBreadcrumbs::links}
	 * for more details on how to specify this property.
	 */
	public $breadcrumbs=array();
	
	public function globalFunction(){
 		
 		
 		$settingsModel  =  new settingsModel;
 		//echo "12";exit;
 		$setArray =  $settingsModel->getAllSiteVariables();
 		foreach($setArray as $settingsarray)
 		{
 			  define($settingsarray->var_name, $settingsarray->var_value);
 		}
 		return true;
	}
	
	
	public function getEmailDetailsById($id){
 		//echo 'a';exit;
 		
 		$emailModel= new emailModel;
				echo 'ab';exit;
				
				$emailArray = $emailModel->getEmaildetailsByEmailId($id);
				//print_r($emailArray);exit;
				
				
 		return $emailArray;
	}
	
	

}
