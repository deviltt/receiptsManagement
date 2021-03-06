package com.tt.oa.controller;

import com.tt.oa.entity.Staff;
import com.tt.oa.global.Content;
import com.tt.oa.service.DepartmentService;
import com.tt.oa.service.StaffService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/staff")
public class StaffController {
    @Autowired
    private StaffService staffService;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/toSelf")
    public String toSelf(Map<String, Object> map, @Param("id")String id){
        map.put("staff", staffService.getStaffById(id));
        return "staff";
    }

    @RequestMapping("/tochangepassword")
    public String toChangePassword(Map<String, Object> map, @Param("id")String id){
        map.put("staff", staffService.getStaffById(id));
        return "changepassword";
    }

    @RequestMapping("/changePassword")
    public String changePassword(@Param("new1")String new1, @Param("new2")String new2){
        Staff staff = (Staff) request.getSession().getAttribute("staff");
        if (new1.equals(new2)){
            staff.setPassword(new1);
            staffService.updateStaff(staff);
            return "redirect:toSelf";
        }
        return "redirect:tochangepassword";
    }

    @RequestMapping("/list")
    public String toStaff(Map<String, Object> map){
        map.put("staffList", staffService.listStaff());
        return "employeelist";
    }

    @RequestMapping("/to_add")
    /**
     * 由于前端有select标签，因此需要传递集合类型的已添加的部门和员工职责集合
     */
    public String toAddStaff(Map<String, Object> map){
        map.put("departmentList", departmentService.listDepartment());
        map.put("duties", Content.getPosts());
        map.put("staff", new Staff());
        return "employeeadd";
    }

    @RequestMapping("/addStaff")
    //通过bean的方式接收form表单参数
    public String addStaff(Staff staff){
        staffService.addStaff(staff);
        return "redirect:list";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public List<Staff> deleteStaff(@Param("id")String id){
        System.out.println(id);
        staffService.deleteStaff(id);
        return staffService.listStaff();
    }

    @RequestMapping("/toupdate")
    public String toUpdateStaff(@Param("id")String id, Map<String, Object> map){
        map.put("departmentList", departmentService.listDepartment());
        map.put("staff", staffService.getStaffById(id));
        map.put("duties", Content.getPosts());
        return "employeeupdate";
    }

    @RequestMapping("/update")
    public String updateStuff(Staff staff){
        staffService.updateStaff(staff);
        return "redirect:list";
    }
}
