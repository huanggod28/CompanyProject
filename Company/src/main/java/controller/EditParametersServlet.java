package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.impl.MachineParametersDaoImpl;
import model.MachineParameters;

    @WebServlet("/EditParametersServlet")
    public class EditParametersServlet extends HttpServlet {
        private static final long serialVersionUID = 1L;

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                int machineId = Integer.parseInt(request.getParameter("machineId"));
                System.out.println("EditParametersServlet.doGet 收到 machineId = " + machineId);
                System.out.println("收到 machineId = " + machineId);

                MachineParametersDaoImpl dao = new MachineParametersDaoImpl();
                MachineParameters params = dao.getParametersByMachineId(machineId);
                System.out.println("DAO 回傳 params = " + params);

                if (params == null) {
                    request.setAttribute("errorMessage", "❌ 找不到該機台參數，請確認 machineId 是否正確");
                } else {
                    request.setAttribute("params", params);
                }

                // ✅ 直接 forward 到 JSP，而不是 VisitorCounterServlet
                request.getRequestDispatcher("/register/editParameters.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "❌ 無效的 machineId 或系統錯誤");
                request.getRequestDispatcher("/register/editParameters.jsp").forward(request, response);
            }
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            int machineId = Integer.parseInt(request.getParameter("machineId"));
            System.out.println("EditParametersServlet.doPost 收到 machineId = " + machineId);

            MachineParameters params = new MachineParameters();
            params.setMachineId(machineId);

            // 逐一接收參數
            params.setInitialGrip(Integer.parseInt(request.getParameter("initialGrip")));
            params.setMoveGrip(Integer.parseInt(request.getParameter("moveGrip")));
            params.setPreDropGrip(Integer.parseInt(request.getParameter("preDropGrip")));
            params.setStrongGrip(Integer.parseInt(request.getParameter("strongGrip")));
            params.setOpenAngle(Integer.parseInt(request.getParameter("openAngle")));
            params.setCloseAngle(Integer.parseInt(request.getParameter("closeAngle")));
            params.setGripDelay(Double.parseDouble(request.getParameter("gripDelay")));

            params.setGuaranteeCount(Integer.parseInt(request.getParameter("guaranteeCount")));
            params.setGuaranteeGrip(Integer.parseInt(request.getParameter("guaranteeGrip")));

            params.setPlayTime(Integer.parseInt(request.getParameter("playTime")));
            params.setzSpeed(Integer.parseInt(request.getParameter("zSpeed")));
            params.setXySpeed(Integer.parseInt(request.getParameter("xySpeed")));
            params.setQuickDrop(request.getParameter("quickDrop"));
            params.setMoveLimit(request.getParameter("moveLimit"));

            params.setPrice(Integer.parseInt(request.getParameter("price")));
            params.setPrice(Integer.parseInt(request.getParameter("max_price")));
            params.setCoinMemory(request.getParameter("coinMemory"));
            params.setResetMode(request.getParameter("resetMode"));

            params.setSoundSwitch(request.getParameter("soundSwitch"));
            params.setVolume(Integer.parseInt(request.getParameter("volume")));
            params.setLightMode(request.getParameter("lightMode"));
            params.setJackpotLight(request.getParameter("jackpotLight"));

            MachineParametersDaoImpl dao = new MachineParametersDaoImpl();
            dao.updateParameters(params);

            // 修改完成後，回到機台資訊頁
            response.sendRedirect("VisitorCounterServlet?page=register/machineInformation.jsp");
        }
    }