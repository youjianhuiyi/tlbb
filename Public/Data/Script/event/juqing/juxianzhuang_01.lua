--200020 
-- ��ؤ�ﳤ�ϵİ����£��������ׯ����

--************************************************************************
--MisDescBegin
--�ű���
x200020_g_ScriptId = 200020

--��������
x200020_g_CopySceneName="����ׯ"

--MisDescEnd
--************************************************************************

--��������
x200020_g_CopySceneName = "����ׯ"

x200020_g_CopySceneType = FUBEN_JUQING	--�������ͣ�������ScriptGlobal.lua����

x200020_g_CopySceneMap = "juxian_1.nav"
x200020_g_Exit = "juxian_1.ini"
x200020_g_LimitMembers = 1				--���Խ���������С��������
x200020_g_TickTime = 5						--�ص��ű���ʱ��ʱ�䣨��λ����/�Σ�
x200020_g_LimitTotalHoldTime = 360--�������Դ���ʱ�䣨��λ��������,�����ʱ�䵽�ˣ������񽫻�ʧ��
x200020_g_LimitTimeSuccess = 500	--����ʱ�����ƣ���λ���������������ʱ�䵽�ˣ��������
x200020_g_CloseTick = 3						--�����ر�ǰ����ʱ����λ��������
x200020_g_NoUserTime = 300				--������û���˺���Լ��������ʱ�䣨��λ���룩
x200020_g_DeadTrans = 0						--����ת��ģʽ��0�������󻹿��Լ����ڸ�����1��������ǿ���Ƴ�����
x200020_g_Fuben_X = 60						--���븱����λ��X
x200020_g_Fuben_Z = 110						--���븱����λ��Z
x200020_g_Back_X = 66							--Դ����λ��X
x200020_g_Back_Z = 56							--Դ����λ��Z

--**********************************
--������ں���
--**********************************
function x200020_OnDefaultEvent( sceneId, selfId, targetId )
	-- ������ҵ������������͵���ͬ�ĸ���
	x200020_MakeCopyScene(sceneId, selfId)
end

--**********************************
--�о��¼�
--**********************************
function x200020_OnEnumerate( sceneId, selfId, targetId )
	-- 0,�������Ѿ����22���񣬾Ͳ����ڽ����������
	if IsMissionHaveDone(sceneId, selfId, 22) > 0   then
		return 0
	end
	
	-- 0,�������Ѿ����21���񣬾Ͳ����ڽ����������
	if IsMissionHaveDone(sceneId, selfId, 21) > 0   then
		if IsHaveMission( sceneId, selfId, 47 ) < 1 then
			AddNumText( sceneId, x200020_g_ScriptId, "����ȥ����ׯ��ҹ�䣩",10 ,-1  )
		end
		return 0
	end

	-- �������Ѿ������20���񣬾Ϳ��Խ���
	if IsMissionHaveDone(sceneId, selfId, 20) > 0   then
		AddNumText( sceneId, x200020_g_ScriptId, "����ȥ����ׯ��ҹ�䣩", 10 ,-1  )
		return 0
	end

	-- 1��ӵ�������Ϊ21������
	if IsHaveMission( sceneId, selfId, 21 ) > 0 then
		AddNumText( sceneId, x200020_g_ScriptId, "����ȥ����ׯ��ҹ�䣩", 10 ,-1  )
		return 0
	end

end

--**********************************
--����������
--**********************************
function x200020_CheckAccept( sceneId, selfId )
	
end

--**********************************
--ѯ������Ƿ�Ҫ���븱��
--**********************************
function x200020_AskEnterCopyScene( sceneId, selfId )
	
end

--**********************************
--����
--**********************************
function x200020_OnAccept( sceneId, selfId, targetId )
	
end

--**********************************
--���ͬ����븱��
--**********************************
function x200020_AcceptEnterCopyScene( sceneId, selfId )
	
end

--**********************************
--��������
--**********************************
function x200020_MakeCopyScene( sceneId, selfId )

	leaderguid=LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "juxian_1.nav"); --��ͼ�Ǳ���ѡȡ�ģ����ұ�����Config/SceneInfo.ini�����ú�
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x200020_g_NoUserTime*1000);
	LuaFnSetCopySceneData_Timer(sceneId, x200020_g_TickTime*1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, x200020_g_CopySceneType);--���ø������ݣ����ｫ0����������������Ϊ999�����ڱ�ʾ������999(�����Զ���)
	LuaFnSetCopySceneData_Param(sceneId, 1, x200020_g_ScriptId);--��1����������Ϊ���������¼��ű���
	LuaFnSetCopySceneData_Param(sceneId, 2, 0);		--���ö�ʱ�����ô���
	LuaFnSetCopySceneData_Param(sceneId, 3, -1);	--���ø�����ڳ�����, ��ʼ��
	LuaFnSetCopySceneData_Param(sceneId, 4, 0);		--���ø����رձ�־, 0���ţ�1�ر�
	LuaFnSetCopySceneData_Param(sceneId, 5, 0);		--�����뿪����ʱ����
	LuaFnSetCopySceneData_Param(sceneId, 6, GetTeamId(sceneId,selfId)); --��������
	LuaFnSetCopySceneData_Param(sceneId, 7, 0) ;	--ɱ��Boss������
	
	-- �����õ��ı������
	for i=8, 31 do
		LuaFnSetCopySceneData_Param(sceneId, i, 0)
	end

	--���ó����еĸ���Npc������
	LuaFnSetSceneLoad_Area( sceneId, "juxian_1_area.ini" )
	LuaFnSetSceneLoad_Monster( sceneId, "juxian_1_monster.ini" )

	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --��ʼ����ɺ���ô�����������
	BeginEvent(sceneId)
		if bRetSceneID>0 then
			AddText(sceneId,"���������ɹ���");
		else
			AddText(sceneId,"���������Ѵ����ޣ����Ժ����ԣ�");
		end
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
end

--**********************************
--�����¼�
--**********************************
function x200020_OnCopySceneReady( sceneId, destsceneId )

	--���븱���Ĺ���
	-- 1���������ļ�û����ӣ��ʹ�������ļ��Լ����븱��
	-- 2, �������ж��飬������Ҳ��Ƕӳ����ʹ����Լ����븱��
	-- 3���������ж��飬������������Ƕӳ����ʹ����Լ��͸�������һ���ȥ

	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId) --���ø�����ڳ�����
	leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId)
	leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid)
	
	if LuaFnIsCanDoScriptLogic( sceneId, leaderObjId ) ~= 1 then			-- �����޷�ִ���߼���״̬
		return
	end
	
	-- �������ǲ����ж���
	if LuaFnHasTeam( sceneId, leaderObjId ) == 0  then   -- û�ж���
		NewWorld( sceneId, leaderObjId, destsceneId, x200020_g_Fuben_X, x200020_g_Fuben_Z) ;
	else
		if IsCaptain(sceneId, leaderObjId) == 0  then
			NewWorld( sceneId, leaderObjId, destsceneId, x200020_g_Fuben_X, x200020_g_Fuben_Z) ;
		else
			local	nearteammembercount = GetNearTeamCount( sceneId, leaderObjId) 
			local mems = {}
			for	i=0,nearteammembercount-1 do
				mems[i] = GetNearTeamMember(sceneId, leaderObjId, i)
				NewWorld( sceneId, mems[i], destsceneId, x200020_g_Fuben_X, x200020_g_Fuben_Z) ;
			end
		end		
	end

end

--**********************************
--����ҽ��븱���¼�
--**********************************
function x200020_OnPlayerEnter( sceneId, selfId )
	
end

--**********************************
--������ڸ����������¼�
--**********************************
function x200020_OnHumanDie( sceneId, selfId, killerId )
	
end

--**********************************
--����
--**********************************
function x200020_OnAbandon( sceneId, selfId )
	
end

--**********************************
-- �سǣ�ֻ�г������񸱱����Ե��ô˽ӿ�
--**********************************
function x200020_BackToCity( sceneId, selfId )
	
end

--**********************************
--����
--**********************************
function x200020_OnContinue( sceneId, selfId, targetId )
	
end	

--**********************************
--����Ƿ�����ύ
--**********************************
function x200020_CheckSubmit( sceneId, selfId, selectRadioId )
	
end

--**********************************
--�ύ
--**********************************
function x200020_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	
end

--**********************************
--ɱ����������
--**********************************
function x200020_OnKillObject( sceneId, selfId, objdataId, objId )

end

--**********************************
--���������¼�
--**********************************
function x200020_OnEnterZone( sceneId, selfId, zoneId )
	
end

--**********************************
--���߸ı�
--**********************************
function x200020_OnItemChanged( sceneId, selfId, itemdataId )
	
end

--**********************************
--����������ʱ���¼�
--**********************************
function x200020_OnCopySceneTimer( sceneId, nowTime )
	
end
