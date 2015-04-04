uint32_t CreatureEvent::executeTalk(Player* player, Player* receiver,uint16_t channelId,SpeakClasses type, std::string& text)
{
        //onTalk(cid, receiver,channel,type,text)
        if(m_interface->reserveEnv())
        {
                ScriptEnviroment* env = m_interface->getEnv();
                if(m_scripted == EVENT_SCRIPT_BUFFER)
                {
                        env->setRealPos(player->getPosition());
                        std::stringstream scriptstream;
                        scriptstream << "local cid = " << env->addThing(player) << std::endl;
                        if (receiver!=NULL)
                        scriptstream << "local receiver = " << env->addThing(receiver) << std::endl;
                        scriptstream << "local channel = " << channelId << std::endl;
                        scriptstream << "local talk_type = " << type << std::endl;
                        scriptstream << "local text = " << text.c_str() << std::endl;
 
            if(m_scriptData)
                        scriptstream << *m_scriptData;
                        bool result = true;
                        if(m_interface->loadBuffer(scriptstream.str()))
                        {
                                lua_State* L = m_interface->getState();
                                result = m_interface->getGlobalBool(L, "_result", true);
                        }
 
                        m_interface->releaseEnv();
                        return result;
                }
                else
                {
                        #ifdef __DEBUG_LUASCRIPTS__
                        char desc[35];
                        sprintf(desc, "%s", player->getName().c_str());
                        env->setEvent(desc);
                        #endif
 
                        env->setScriptId(m_scriptId, m_interface);
                        env->setRealPos(player->getPosition());
 
                        lua_State* L = m_interface->getState();
                        m_interface->pushFunction(m_scriptId);
 
                        lua_pushnumber(L, env->addThing(player));
                        if (receiver!=NULL)
                        lua_pushnumber(L, env->addThing(receiver));
                        lua_pushnumber(L, channelId);
                        lua_pushnumber(L, type);
                        lua_pushstring(L, text.c_str());
 
                        bool result = m_interface->callFunction(3);
                        m_interface->releaseEnv();
                        return result;
                }
        }
        else
        {
                std::clog << "[Error - CreatureEvent::executeTalk] Call stack overflow." << std::endl;
                return 0;
        }
}