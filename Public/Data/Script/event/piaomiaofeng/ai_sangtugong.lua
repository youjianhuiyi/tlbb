--Ʈ��� ɣ����AI

--A �����ݡ�BOSS��HPÿ��ʧ20%�����ʧ20��....ͬʱ����С������Ϊ1122ֻ..����or����ս����ʧ....
--B ��ţë���롿������״̬ʱÿ��20һ�δ�Χ����....����״̬��CD������ֻ�ǲ�ʹ��....���ݽ���ʱ��CD....
--C �����������������ʱ������2��buff....ͬʱ����ϴε�2��buff....
--D �����ս��5���Ӻ���Լ������н�ʬ��һ������buff....����ʹ��AB(C)....

--ȫ�̶����������ƶ����ܵ�buff....
--����ս��������ʱɾ����ʬ....


--�ű���
x402265_g_ScriptId	= 402265

--�����߼��ű���....
x402265_g_FuBenScriptId = 402263


--�����ض�����buff....
x402265_Buff_MianYi1	= 10472	--����һЩ����Ч��....
x402265_Buff_MianYi2	= 10471	--������ͨ����....

--A����....
x402265_SkillA_TuDun				= 1028
x402265_SkillA_ChildName		= "���׽�ʬ"
x402265_SkillA_ChildBuff		= 10246
x402265_SkillA_ChildTime		= 5000		--���ݶ೤ʱ���ʼˢС��....
x402265_SkillA_Time					= 20000		--���ݳ�����ʱ��....


--Bţë����....
x402265_SkillB_NiuMaoDuZhen = 1029
--��ȴʱ��....
x402265_SkillB_CD						= 20000


--C�������＼�ܵ�buff�б�....
x402265_SkillC_ChutuBuff1 = { 10237, 10238 }
x402265_SkillC_ChutuBuff2 = { 10239, 10240, 10241, 10242 }


--D���....
x402265_SkillD_Buff1	= 10234
x402265_SkillD_Buff2	= 10235
--��ʼ�����״̬��ʱ��....
x402265_EnterKuangBaoTime	= 5*60*1000


--AI Index....
x402265_IDX_HPStep							= 1	--Ѫ������....
x402265_IDX_SkillB_CD						= 2	--B���ܵ�CDʱ��....
x402265_IDX_KuangBaoTimer				= 3	--�񱩵ļ�ʱ��....
x402265_IDX_TuDunTimer					= 4	--���ݵļ�ʱ��....���ڼ����ʱ���ݽ���....
x402265_IDX_NeedCreateChildNum	= 5	--��Ҫ������С�ֵ�����....

x402265_IDX_CombatFlag 			= 1	--�Ƿ���ս��״̬�ı�־....
x402265_IDX_IsTudunMode			= 2	--�Ƿ�������ģʽ�ı�־....
x402265_IDX_IsKuangBaoMode	= 3	--�Ƿ��ڿ�ģʽ�ı�־....


--**********************************
--��ʼ��....
--**********************************
function x402265_OnInit(sceneId, selfId)
	--����AI....
	x402265_ResetMyAI( sceneId, selfId )
end


--**********************************
--����....
--**********************************
function x402265_OnHeartBeat(sceneId, selfId, nTick)

	--����ǲ�������....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--����Ƿ���ս��״̬....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402265_IDX_CombatFlag ) then
		return
	end

	--��״̬����Ҫ���߼�....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402265_IDX_IsKuangBaoMode ) then
		return
	end

	--ִ�п��߼�....
	if 1 == x402265_DoSkillD_KuangBao( sceneId, selfId, nTick ) then
		return
	end

	--ִ�������߼�....
	if 1 == x402265_SkillLogicA_TunDun( sceneId, selfId, nTick ) then
		return
	end

	--ִ��ţë�����߼�....
	if 1 == x402265_SkillLogicB_NiuMaoDuZhen( sceneId, selfId, nTick ) then
		return
	end

end


--**********************************
--����ս��....
--**********************************
function x402265_OnEnterCombat(sceneId, selfId, enmeyId)

	--�ӳ�ʼbuff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402265_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402265_Buff_MianYi2, 0 )

	--����AI....
	x402265_ResetMyAI( sceneId, selfId )

	--���ý���ս��״̬....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402265_IDX_CombatFlag, 1 )

end


--**********************************
--�뿪ս��....
--**********************************
function x402265_OnLeaveCombat(sceneId, selfId)

	--����AI....
	x402265_ResetMyAI( sceneId, selfId )

	--ɾ���Լ�....
	LuaFnDeleteMonster( sceneId, selfId )

	--�����Ի�NPC....
	local MstId = CallScriptFunction( x402265_g_FuBenScriptId, "CreateBOSS", sceneId, "SangTuGong_NPC", -1, -1 )
	SetUnitReputationID( sceneId, MstId, MstId, 0 )

end


--**********************************
--ɱ������....
--**********************************
function x402265_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--����....
--**********************************
function x402265_OnDie( sceneId, selfId, killerId )

	--����AI....
	x402265_ResetMyAI( sceneId, selfId )

	--�����Ѿ���ս��ɣ����....
	CallScriptFunction( x402265_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "SangTuGong", 2 )

	--�����û����ս�����ϴ��������ս���ϴ�....
	if 2 ~= CallScriptFunction( x402265_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "WuLaoDa" )	then
		CallScriptFunction( x402265_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "WuLaoDa", 1 )
	end
	
	-- zchw ȫ�򹫸�
	local	playerName	= GetName( sceneId, killerId )
	
	--ɱ��������ǳ������ȡ�����˵�����....
	local playerID = killerId
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then
		playerID = GetPetCreator( sceneId, killerId )
		playerName = GetName( sceneId, playerID )
	end
	
	--��������������ȡ�ӳ�������....
	local leaderID = GetTeamLeader( sceneId, playerID )
	if leaderID ~= -1 then
		playerName = GetName( sceneId, leaderID )
	end
	
	if playerName ~= nil then
		str = format("#{_INFOUSR%s}#{PMF_8812_02}", playerName); --ɣ����
		AddGlobalCountNews( sceneId, str )
	end
	
end


--**********************************
--����AI....
--**********************************
function x402265_ResetMyAI( sceneId, selfId )

	--���ò���....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_HPStep, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_SkillB_CD, x402265_SkillB_CD )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_KuangBaoTimer, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_TuDunTimer, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_NeedCreateChildNum, 0 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402265_IDX_CombatFlag, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402265_IDX_IsTudunMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402265_IDX_IsKuangBaoMode, 0 )

	--���buff....
	for i, buffId in x402265_SkillC_ChutuBuff1 do
		LuaFnCancelSpecificImpact( sceneId, selfId, buffId )
	end

	for i, buffId in x402265_SkillC_ChutuBuff2 do
		LuaFnCancelSpecificImpact( sceneId, selfId, buffId )
	end

	LuaFnCancelSpecificImpact( sceneId, selfId, x402265_SkillD_Buff1 )
	LuaFnCancelSpecificImpact( sceneId, selfId, x402265_SkillD_Buff2 )

	--���С��....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if GetName(sceneId, MonsterId) == x402265_SkillA_ChildName then
			LuaFnDeleteMonster(sceneId, MonsterId)
		end
	end

end


--**********************************
--�񱩼���....
--**********************************
function x402265_DoSkillD_KuangBao( sceneId, selfId )

	--�ӿ�buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402265_SkillD_Buff1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402265_SkillD_Buff2, 0 )

	--������С�ּӿ�....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if GetName(sceneId, MonsterId) == x402265_SkillA_ChildName then
			LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x402265_SkillD_Buff1, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x402265_SkillD_Buff2, 0 )
		end
	end

end


--**********************************
--�����߼�....
--**********************************
function x402265_SkillLogicA_TunDun( sceneId, selfId, nTick )


	--����ģʽ��������ݵļ�ʱ��....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402265_IDX_IsTudunMode ) then

		local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402265_IDX_TuDunTimer )
		if cd > nTick then

			MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_TuDunTimer, cd-nTick )
			--�������ˢС�ֵ�ʱ�䲢�ұ������ݻ�ûˢ��С��....
			if cd < (x402265_SkillA_Time-x402265_SkillA_ChildTime) then
				local needCreateNum = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402265_IDX_NeedCreateChildNum )
				if needCreateNum > 0 then
					--����С��....
					MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_NeedCreateChildNum, 0 )
					local x,z = GetWorldPos( sceneId, selfId )
					for i=1, needCreateNum do
						local MstId = CallScriptFunction( x402265_g_FuBenScriptId, "CreateBOSS", sceneId, "JiangShi_BOSS", x, z )
						LuaFnSendSpecificImpactToUnit( sceneId, MstId, MstId, MstId, x402265_SkillA_ChildBuff, 0 )
						SetCharacterName( sceneId, MstId, x402265_SkillA_ChildName )
					end
				end
			end

		else

			--���ݽ���....�����뿪����״̬....
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_TuDunTimer, 0 )
			MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402265_IDX_IsTudunMode, 0 )
			--����ţë����CD....
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_SkillB_CD, x402265_SkillB_CD )

		end


	--������ģʽ�����Ƿ���Խ�������ģʽ....
	else


		--ÿ����20%Ѫʱ��������ģʽ....
		local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
		local LastStep = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402265_IDX_HPStep )
		local CurStep = -1
		if CurPercent <= 0.2 then
			CurStep = 4
		elseif CurPercent <= 0.4 then
		 	CurStep = 3
		elseif CurPercent <= 0.6 then
		 	CurStep = 2
		elseif CurPercent <= 0.8 then
			CurStep = 1
		end

		--��������....
		if CurStep > LastStep then
			--���Լ���������and���ܹ���....
			local x,z = GetWorldPos( sceneId, selfId )
			LuaFnUnitUseSkill( sceneId, selfId, x402265_SkillA_TuDun, selfId, x, z, 0, 1 )

			--������2��buff(��������)....
			local idx1 = random( getn(x402265_SkillC_ChutuBuff1) )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402265_SkillC_ChutuBuff1[idx1], 0 )
			local idx2 = random( getn(x402265_SkillC_ChutuBuff2) )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402265_SkillC_ChutuBuff2[idx2], 0 )

			local NeedCreateNum = 1
			if CurStep == 3 or CurStep == 4 then
				NeedCreateNum = 2
			end

			MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402265_IDX_IsTudunMode, 1 )
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_NeedCreateChildNum, NeedCreateNum )
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_HPStep, CurStep )
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_TuDunTimer, x402265_SkillA_Time )
			return 1
		end


	end

	return 0

end


--**********************************
--ţë�����߼�....
--**********************************
function x402265_SkillLogicB_NiuMaoDuZhen( sceneId, selfId, nTick )

	--���¼���CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402265_IDX_SkillB_CD )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_SkillB_CD, cd-nTick )
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_SkillB_CD, x402265_SkillB_CD-(nTick-cd) )
		--������״̬�ſ�����....
		if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402265_IDX_IsTudunMode ) then
			local x,z = GetWorldPos( sceneId, selfId )
			MonsterTalk( sceneId, -1, "", "#{PMF_20080530_16}" )
			LuaFnUnitUseSkill( sceneId, selfId, x402265_SkillB_NiuMaoDuZhen, selfId, x, z, 0, 0 )
			return 1
		end
	end

	return 0

end


--**********************************
--���߼�....
--**********************************
function x402265_DoSkillD_KuangBao( sceneId, selfId, nTick )

	--����Ƿ��˿񱩵�ʱ��....
	local kbTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402265_IDX_KuangBaoTimer )
	if kbTime < x402265_EnterKuangBaoTime then

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402265_IDX_KuangBaoTimer, kbTime+nTick )

	else

		MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402265_IDX_IsKuangBaoMode, 1 )
		--�ӿ�buff....
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402265_SkillD_Buff1, 0 )
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402265_SkillD_Buff2, 0 )
		--������С�ּӿ�buff....
		local nMonsterNum = GetMonsterCount(sceneId)
		for i=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			if GetName(sceneId, MonsterId) == x402265_SkillA_ChildName then
				LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x402265_SkillD_Buff1, 0 )
				LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x402265_SkillD_Buff2, 0 )
			end
		end
		return 1

	end


	return 0

end