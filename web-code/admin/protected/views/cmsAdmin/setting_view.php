<div class="modal-dialog modal-sm">
  <div class="modal-content col-md-12 col-sm-12 viewProfile">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      <h4 class="modal-title"><i class=""></i> Settings</h4>
    </div>
    <div class="">    
    <div class="editSettingsOuter"> 
      <table class="table table-bordered">
      	<tr>
        	<td>
            	<label>Push Notification  </label>
            </td>
            <td>
            	<input id="notification" type="radio" name="notification" <?php if (!empty($setting_details) && $setting_details->push_notification=="1") echo "checked";?> value="1"> Yes
            </td>
            <td>
          		<input id="notification" type="radio" name="notification" <?php if (!empty($setting_details) && $setting_details->push_notification=="0") echo "checked";?> value="0"> No  
            </td>
        </tr>
        
        <tr>
        	<td>
            	<label>Receive Email  </label>
            </td>
            <td>
            	<input id="receive_email" type="radio" name="receive_email" <?php if (!empty($setting_details) && $setting_details->receive_email=="1") echo "checked";?> value="1"> Yes
            </td>
            <td>
          		<input id="receive_email" type="radio" name="receive_email" <?php if (!empty($setting_details) && $setting_details->receive_email=="0") echo "checked";?> value="0"> No
            </td>
        </tr>
        
        <tr>
        	<td>
            	<label>Stay Sign In  </label>
            </td>
            <td>
            	<input id="stay_sign" type="radio" name="stay_sign" <?php if (!empty($setting_details) && $setting_details->stay_sign_in=="1") echo "checked";?> value="1"> Yes
            </td>
            <td>
          		<input id="stay_sign" type="radio" name="stay_sign" <?php if (!empty($setting_details) && $setting_details->stay_sign_in=="0") echo "checked";?> value="0"> No
            </td>
        </tr>
      </table>             
        
    </div>        
        <div class="text-center">
            <button type="submit" onclick="save_setting_view(<?php echo $user_id; ?>)" class="btn btn-primary margin ">
                <i class="fa fa-save"></i>
                SAVE
            </button>
        </div>
    </div>
  </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript">
  function save_setting_view(user_id)
  {
    var notification = $("input[name=notification]:checked").val()
    var receive_email = $("input[name=receive_email]:checked").val()
    var stay_sign = $("input[name=stay_sign]:checked").val()
     $.post(BASE_URL+'/cmsAdmin/user/save_setting_view',
		{
			'notification':notification,
			'receive_email':receive_email,
			'stay_sign' : stay_sign,
			'user_id':user_id
		},
		function(data)
		{
			if (data == 'Duplicate')
			{
					 
			}
			else if(data == 'success')
			{     
				window.location.reload(); //Refersh The page to set the session and update the task accordigly
			}
		});
  }
</script>